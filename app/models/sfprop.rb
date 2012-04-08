class Sfprop < ActiveRecord::Base
    inherits_from :listing, :methods => true

    include JsonMethodArray

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "AREA_SHORT" if header == "AREA"
            header
        end
    end

    def as_json (options={})
        super(:methods => get_methods_array())
    end

end
