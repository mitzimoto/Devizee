class Town < ActiveRecord::Base
    has_many :listings, :foreign_key => :list_no
    belongs_to :county, :foreign_key => :short
end
