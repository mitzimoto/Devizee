require 'fileutils'
require 'net/ftp'

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

    @@photo_num_map = {
        0     =>  0,
        1     =>  1,  2     =>  2,  3     =>  3,
        4     =>  4,  5     =>  5,  6     =>  6,
        7     =>  7,  8     =>  8,  9     =>  9,
        10    => 'A', 11    => 'B', 12    => 'C',
        13    => 'D', 14    => 'E', 15    => 'F',
        16    => 'G', 17    => 'H', 18    => 'I',
        19    => 'J', 20    => 'K', 21    => 'L',
        22    => 'M', 23    => 'N', 24    => 'O',
        25    => 'P', 26    => 'Q', 27    => 'R',
        28    => 'S', 29    => 'T', 30    => 'U',
        31    => 'V', 32    => 'W', 33    => 'X',
        34    => 'Y', 35    => 'Z'
    }

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

        order_by = {
            'newest'    =>  'list_no DESC',
            'priceasc'  =>  'list_price ASC',
            'pricedsc'  =>  'list_price DESC',
            'photo_count' => 'photo_count DESC'
        }

        params[:sort]       = 'newest' if params[:sort].blank?
        params[:sort]       = 'newest' unless order_by.has_key?(params[:sort])

        puts order_by[params[:sort]]

        Listing.paginate(:page => params[:page])
        .where("no_bedrooms >= ?", params[:beds])
        .where("no_full_baths + no_half_baths >= ?", params[:baths].to_i)
        .where("list_price BETWEEN ? AND ?", params[:minprice], params[:maxprice])
        .where("square_feet BETWEEN ? AND ?", params[:minsqft], params[:maxsqft])
        .where("town_num BETWEEN ? AND ? ", params[:mintown], params[:maxtown])
        .order(order_by[params[:sort]])


    end

    def self.download_photo(num, photo)
        photo_path = Listing.get_photo_url num, photo #photo/xx/xxx/xxx_x.jpg
        photo_full_path = "app/assets/images/mls/#{photo_path}"

        unless File.exists?(photo_full_path)
            ftp = Net::FTP.new('ftp.mlspin.com')
            ftp.login

            dirname  = File.dirname(photo_path)
            basename = File.basename(photo_path)

            %x[ mkdir -p "app/assets/images/mls/#{dirname}" ]

            begin
                Timeout.timeout(2) do
                    ftp.getbinaryfile("#{dirname}/#{basename}", "#{photo_full_path}")
                end
            rescue
                ftp.close
                File.unlink("#{photo_full_path}")
                photo_full_path = "app/assets/images/photo-not-available.jpeg"
            end

            ftp.close
        end

        return photo_full_path

    end

    def self.get_photo_url(num,photo)
        strnum = num.to_s
        return "photo/#{strnum[0..1]}/#{strnum[2..4]}/#{strnum[5..7]}_#{@@photo_num_map[photo]}.jpg"
    end

    def photo_at_index(photo=0)
        num = self.list_no.to_s
        return "photo/#{num[0..1]}/#{num[2..4]}/#{num[5..7]}_#{@@photo_num_map[photo]}.jpg"
    end

    def street_no_titleized
        return self.street_no.titleize
    end

    def street_name_titleized
        return self.street_name.titleize
    end

    def address_truncated
        return truncate "#{self.street_no} #{self.street_name.titleize}", :length => 25, :omission => "..."
    end

    def address_slug
        str = "#{self.street_no} #{self.street_name} #{self.town.long} #{self.town.state}"
        str.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def address
        return "#{self.street_no} #{self.street_name.titleize}"
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

    def total_baths
        self.no_full_baths = 0 unless self.no_full_baths
        self.no_half_baths = 0 unless self.no_half_baths
        return self.no_half_baths  + self.no_full_baths
    end

    def human_basement
        return self.basement == 'Y' ? 'Yes' : 'No'
    end

end
