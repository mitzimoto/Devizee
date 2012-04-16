
class Listing < ActiveRecord::Base
    acts_as_superclass
    belongs_to :agent,  :foreign_key => :agent_code
    belongs_to :office, :foreign_key => :office_code
    belongs_to :town,   :foreign_key => :town_num
    belongs_to :area,   :foreign_key => :area_short

    has_many :sfprops
    has_many :lands
    has_many :condos
    has_many :mobile_homes

    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::TextHelper

    def self.fix_headers (headers)
        headers.map! do |header|
            header = "AREA_SHORT" if header == "AREA"
            header
        end

    end

    def self.search (params)

        params[:page]       = 1 if params[:page].blank?
        params[:beds]       = 1 if params[:beds].blank?
        params[:baths]      = 1 if params[:baths].blank?
        params[:minprice]   = 0 if params[:minprice].blank?
        params[:maxprice]   = 20000000 if params[:maxprice].blank?
        params[:minsqft]    = 0 if params[:minsqft].blank?
        params[:maxsqft]    = 1000000 if params[:maxsqft].blank?
        params[:mintown]    = 0 if params[:mintown].blank?
        params[:maxtown]    = 10000 if params[:maxtown].blank?

        Listing.paginate(:page => params[:page])
        .where("no_bedrooms >= ?", params[:beds])
        .where("no_full_baths + no_half_baths >= ?", params[:baths].to_i)
        .where("list_price BETWEEN ? AND ?", params[:minprice], params[:maxprice])
        .where("square_feet BETWEEN ? AND ?", params[:minsqft], params[:maxsqft])
        .where("town_num BETWEEN ? AND ? ", params[:mintown], params[:maxtown])

    end

    def self.get_photo_url(num,photo)
        return "photo/#{num[0..1]}/#{num[2..4]}/#{num[5..7]}_#{photo}.jpg"
    end

    def street_no_titleized
        return self.street_no.titleize

    end

    def street_name_titleized
        return self.street_name.titleize
    end

    def address_truncated
        return truncate "#{self.street_no} #{self.street_name.titleize}", :length => 19, :omission => "..."
    end

    def list_price_currency
        return number_to_currency self.list_price, :precision => 0
    end

    def square_feet_delimited
        return number_with_delimiter self.square_feet
    end

    def photo_url 
        return Listing.get_photo_url(self.list_no, 0)
    end

end
