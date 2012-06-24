class HomeController < ApplicationController
    def index
        #render :text => params[:page]
        params[:page] = 1 if params[:page].blank?
        puts params

        #@listings = Listing.order('list_no DESC').limit( (params[:page].to_i * Listing.per_page ) ).all(:include => [:town])
        @listings = Listing.search params
        #puts Sfprop.find_all_by_listing_id(70440179) 
    end
end
