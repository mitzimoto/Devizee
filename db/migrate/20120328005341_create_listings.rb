class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|

      #PALL
      t.string    :subtype, :null => false
      t.string    :list_no
      t.string    :list_agent
      t.string    :list_office
      t.string    :status
      t.integer   :list_price
      t.integer   :town_num
      t.string    :area
      t.string    :zip_code
      t.integer   :photo_count
      t.string    :photo_date
      t.string    :photo_mask
      t.string    :lender_owned
      t.string    :virtual_tours
      t.string    :open_houses
      t.string    :street_no
      t.string    :street_name
      t.integer   :taxes
      t.string    :tax_year


      t.timestamps
    end
  end
end
