module MultipleTableInheritance
  module Child
    module Base
      def self.default_options
        { :dependent => :destroy, :methods => false }
      end
      
      def self.included(base)
        base.extend ClassMethods
        base.class_attribute :parent_association_name
      end
      
      module ClassMethods
        def inherits_from(association_name, options={})
          # Standardize options, and remove those that should not affect the belongs_to relationship
          options = Base::default_options.merge(options.to_options)
          inherit_methods = options.delete(:methods)
          
          @inherited_attribute_methods_mutex = Mutex.new
          
          extend AttributeMethods, FinderMethods
          include InstanceMethods
          include DelegateMethods if inherit_methods
          
          self.parent_association_name = association_name.to_sym
          self.primary_key = "#{parent_association_name}_id"
          
          define_parent_association_builder
          
          # Bind relationship, handle validation, and save properly.
          belongs_to parent_association_name, options
          alias_method_chain parent_association_name, :autobuild
          validate :parent_association_must_be_valid
          before_save :parent_association_must_be_saved
        end
        
        def parent_association_class
          @parent_association_class ||= begin
            reflection = create_reflection(:belongs_to, parent_association_name, {}, self)
            reflection.klass
          end
        end
        
        private
        
        def define_parent_association_builder
          subtype_column = parent_association_class.subtype_column
          define_method("#{parent_association_name}_with_autobuild") do
            unless association = send("#{parent_association_name}_without_autobuild")
              association = send("build_#{parent_association_name}")
              association.send("#{subtype_column}=", self.class.to_s)
            end
            association
          end
        end
        
        def inherited_columns_and_associations
          # Get the associated columns and relationship names
          inherited_columns = parent_association_class.column_names - column_names
          inherited_methods = parent_association_class.reflections.map { |key, value| key.to_s }
          
          # Filter out methods that the class already has
          inherited_methods = inherited_methods.reject do |method|
            self.reflections.map { |key, value| key.to_s }.include?(method)
          end
          
          inherited_columns + inherited_methods - ['id']
        end
      end
      
      module AttributeMethods
        def define_attribute_methods
          super
          
          @inherited_attribute_methods_mutex.synchronize do
            return if inherited_attribute_methods_generated?
            inherit_parent_attributes
            inherit_parent_accessible_attributes
            inherited_attribute_methods_generated!
          end
        end
        
        def inherit_parent_attributes
          inherited_columns_and_associations.each do |name|
            delegate name, "#{name}=", :to => parent_association_name
          end
        end
        
        def inherit_parent_accessible_attributes
          parent_association_class.accessible_attributes.each do |attr|
            attr_accessible attr.to_sym
          end
        end
        
        def inherited_attribute_methods_generated?
          @inherited_attribute_methods_generated ||= false
        end
        
        def inherited_attribute_methods_generated!
          @inherited_attribute_methods_generated = true
        end
      end
      
      module FinderMethods
        def find_by_sql(*args)
          child_records = super(*args)
          
          ids = child_records.collect(&:id)
          parent_records = parent_association_class.as_supertype.find_all_by_id(ids)
          
          child_records.each do |child|
            parent = parent_records.find { |parent| parent.id == child.id }
            child.send(:parent_association=, parent) if parent
          end
        end
        
        def find_by_id(*args)
          send("find_by_#{parent_association_name}_id", *args)
        end
      end
      
      module InstanceMethods
        protected
        
        def sanitize_for_mass_assignment(attributes, role = :default)
          Child::Sanitizer.new(self.class, role).sanitize(attributes)
        end
        
        public 
        
        def parent_association
          send(parent_association_name)
        end
        
        private

        def parent_association=(record)
          send("#{parent_association_name}=", record)
        end
        
        def parent_association_must_be_valid
          association = parent_association
          
          unless valid = association.valid?
            association.errors.each do |attr, message|
              errors.add(attr, message)
            end
          end
          
          valid
        end
        
        def parent_association_must_be_saved
          association = parent_association
          association.save(:validate => false)
          self.id = association.id
        end
      end
      
      module DelegateMethods
        def method_missing(name, *args, &block)
          if parent_association_respond_to?(name)
            parent_association.send(name, *args, &block)
          else
            super
          end
        end
        
        def respond_to?(name, *args)
          super || parent_association_respond_to?(name)
        end
        
        private
        
        def parent_association_respond_to?(name)
          parent_association_loaded? && parent_association.respond_to?(name)
        end
        
        def parent_association_loaded?
          !!association_instance_get(parent_association_name)
        end
      end
    end
  end
end
