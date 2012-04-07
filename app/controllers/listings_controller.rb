class ListingsController < ApplicationController

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.where(:list_no => params[:list_no])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listing}
    end 
  end

  def search

    page  = params[:page]   || 1
    beds  = params[:beds]   || 1
    baths = params[:baths]  || 1


    criteria = {
      :page => page
    }

    @listings = Listing.paginate(:page => page).joins(:sfprops).joins(:lands).where( :any => {:no_bedrooms => 2} )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listings}
    end 
  end

end
