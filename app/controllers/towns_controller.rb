class TownsController < ApplicationController

    def autocomplete
        
        @towns = {}
        @towns = Town.starts_with params[:q] unless params[:q].blank?

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @towns }
        end 
    end


end
