class Listing < ActiveRecord::Base
    acts_as_superclass
    belongs_to :agent,  :foreign_key => :agent_code
    belongs_to :office, :foreign_key => :office_code
    belongs_to :town,   :foreign_key => :town_num
    belongs_to :area,   :foreign_key => :area_short

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "AREA_SHORT" if header == "AREA"
            header
        end

    end

    def self.get_photo_url(num,photo)
        return "photo/#{num[0..1]}/#{num[2..4]}/#{num[5..7]}_#{photo}.jpg"
    end


end
