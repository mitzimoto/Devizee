class Town < ActiveRecord::Base
    has_many :listings, :foreign_key => :town_num
    belongs_to :county, :foreign_key => :county_short

    # For now, comment this line out when loading the towns into the database
    #set_primary_key :num

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "COUNTY_SHORT" if header == "COUNTY"
            header = "NUM" if header == "TOWN_NUM"
            header
        end
    end

    def self.starts_with(query="")
	Town.select("`long`,`state`,`num`").where("LOWER(`long`) LIKE '#{query.downcase}%'").limit(10)
    end

    def town_and_state
        return "#{self.long}, #{self.state}"
    end

    def as_json(options={})
        super( :methods => [:town_and_state] )
    end
end
