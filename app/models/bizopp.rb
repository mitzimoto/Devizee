class Bizopp < ActiveRecord::Base
    inherits_from :listing, :class_name => 'Resources::Listing'
end
