class CreateSfprops < ActiveRecord::Migration
  def change
    create_table :sfprops, :inherits => :listing do |t|
        t.string    :sf_type
        t.string    :style
        t.integer   :lot_size
        t.float     :acre 
        t.integer   :square_feet 
        t.integer   :garage_spaces
        t.integer   :garage_parking
        t.string    :basement
        t.integer   :no_rooms
        t.integer   :no_beedrooms
        t.integer   :no_full_baths
        t.integer   :no_half_baths
        t.string    :master_bath

        t.string    :liv_level
        t.string    :liv_dimen 
        t.string    :din_level 
        t.string    :din_dimen
        t.string    :fam_level 
        t.string    :fam_dimen 
        t.string    :kit_level 
        t.string    :kit_dimen
        t.string    :mbr_level 
        t.string    :mbr_dimen

        t.string    :bed2_level
        t.string    :bed2_dimen 
        t.string    :bed3_level 
        t.string    :bed3_dimen 
        t.string    :bed4_level 
        t.string    :bed4_dimen
        t.string    :bed5_level 
        t.string    :bed5_dimen 

        t.string    :bth1_level 
        t.string    :bth1_dimen 
        t.string    :bth2_level 
        t.string    :bth2_dimen
        t.string    :bth3_level 
        t.string    :bth3_dimen

        t.string    :laundry_level 
        t.string    :laundry_dimen 
        t.string    :oth1_room_name 
        t.string    :oth1_level 
        t.string    :oth1_dimen
        t.string    :oth2_room_name 
        t.string    :oth2_level 
        t.string    :oth2_dimen
        t.string    :oth3_room_name 
        t.string    :oth3_level 
        t.string    :oth3_dimen
        t.string    :oth4_room_name 
        t.string    :oth4_level 
        t.string    :oth4_dimen
        t.string    :oth5_room_name 
        t.string    :oth5_level
        t.string    :oth5_dimen
        t.string    :oth6_level
        t.string    :oth6_dimen

        t.integer   :year_built

        t.integer   :assessments

      t.timestamps
    end
  end
end
