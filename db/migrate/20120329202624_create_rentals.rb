class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals, :inherits => :listing do |t|
        t.string    :rn_type
        t.integer   :parking_spaces     
      t.timestamps
    end
  end
end
