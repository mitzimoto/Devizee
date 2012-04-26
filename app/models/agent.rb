class Agent < ActiveRecord::Base
    has_many :listings, :foreign_key => :agent_code

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "CODE" if header == "ID"
            header
        end
    end
end