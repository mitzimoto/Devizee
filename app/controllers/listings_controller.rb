

class ListingsController < ApplicationController

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.where(:list_no => params[:list_no]).first()

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listing}
    end 
  end

  def search

    @listings = Listing.search(params)

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @listings}
    end 
  end

  def photo

   #@photo_path = Listing.get_photo_url params[:list_no], params[:photo_no]
   #@photo_path = "app/assets/images/mls/#{@photo_path}"

   #if !File.exists?(@photo_path)
   #  #do something
   #end

    @photo_path = Listing.display_photo params[:list_no], params[:photo_no].to_i
  
    #respond_to do |format|
    #  format.html # search.html.erb
    #  format.json { render json: @listings}
    #end 

    File.open(@photo_path, 'rb') do |f|
      send_data f.read, :type => "image/jpeg", :disposition => "inline"
    end

  end

  def download

    @listing = Listing.where(:list_no => params[:list_no]).first()

    status = 'noop'
#
    if params[:list_no] and @listing.photo_count > 1
      status = Listing.download_photos params[:list_no] 
    end

    respond_to do |format|
      format.json { render :json => {:status => status} }
    end

  end

end
