class Listing < ActiveRecord::Base
    acts_as_superclass
    belongs_to :agent,  :foreign_key => :list_agent
    belongs_to :office, :foreign_key => :list_office
    belongs_to :town,   :foreign_key => :town_num
    belongs_to :area,   :foreign_key => :area_code
end
