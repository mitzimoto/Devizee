class Town < ActiveRecord::Base
    has_many :listings, :foreign_key => :town_num
    belongs_to :county, :foreign_key => :county_short

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "COUNTY_SHORT" if header == "COUNTY"
            header = "NUM" if header == "TOWN_NUM"
            header
        end

    end
end
