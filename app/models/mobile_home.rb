class MobileHome < ActiveRecord::Base
    inherits_from :listing

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "AREA_SHORT" if header == "AREA"
            header
        end

    end
end
