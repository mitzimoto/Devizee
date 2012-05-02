class HomeController < ApplicationController
    def index
        @listings = Listing.order('list_no DESC').limit(50).all(:include => [:town])
    end
end
