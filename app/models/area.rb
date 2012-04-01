class Area < ActiveRecord::Base
    has_many :listings, :foreign_key => :area_short

    def self.fix_headers (headers)

    end
end
