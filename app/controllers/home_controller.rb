class HomeController < ApplicationController
    def index
        #render :text => params[:page]
        params[:page] = 1 if params[:page].blank?

        @listings = Listing.order('list_no DESC').limit( (params[:page].to_i * Listing.per_page ) ).all(:include => [:town])
    end
end
