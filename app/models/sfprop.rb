class Sfprop < ActiveRecord::Base
    inherits_from :listing, :methods => true

    #def self.primary_key
    #    "listing_id"
    #end

    include JsonMethodArray

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
        item = self.new(options)
        item.parent_association.id = item.list_no
        item.save!
    end

    def as_json (options={})
        super(:methods => get_methods_array())
    end

    def prop_type
        return 'Single Family'
    end
end
