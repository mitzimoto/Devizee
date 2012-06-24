class Sfprop < ActiveRecord::Base
    inherits_from :listing, :methods => true

    #def self.primary_key
    #    "listing_id"
    #end

    include JsonMethodArray

        def attributes_protected_by_default
            # default is ["id", "type"]
            []
        end

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "AREA_SHORT" if header == "AREA"
            header
        end
    end

    def self.empty_all
        Listing.delete_all
	   self.delete_all
    end

    def self.addnew(options={})
        self.create(options)
        #item = self.new(options)
        #item.list_no = options[:list_no]
        #item.save!
        #puts item.list_no
    end

    def as_json (options={})
        super(:methods => get_methods_array())
    end

    def prop_type
        return 'Single Family'
    end
end
