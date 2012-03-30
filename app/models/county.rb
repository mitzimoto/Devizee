class County < ActiveRecord::Base
    has_many :towns, :foreign_key => :town_num
end
