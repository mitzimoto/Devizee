class HomeController < ApplicationController
    def index
        @listings = Listing.limit(50).all
    end
end
