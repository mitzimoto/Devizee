class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals, :inherits => :listing do |t|
        t.string    :rn_type
        t.integer   :no_rooms
        t.integer   :no_bedrooms
        t.integer   :no_full_baths
        t.integer   :no_half_baths
        t.string    :master_bath
        t.integer   :parking_spaces
        t.integer   :lot_size
        t.integer   :square_feet        
      t.timestamps
    end
  end
end
