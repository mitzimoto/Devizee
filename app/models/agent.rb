class Agent < ActiveRecord::Base
    has_many :listings, :foreign_key => :list_no
end
