class County < ActiveRecord::Base
    has_many :towns, :foreign_key => :county_short

    def self.fix_headers (headers)

    end
end
