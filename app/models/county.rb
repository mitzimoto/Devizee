class County < ActiveRecord::Base
    has_many :towns, :foreign_key => :county_short

    def self.fix_headers (headers)

    end

    def self.addnew(options={})
        item = self.new(options)
        item.save
    end
end
