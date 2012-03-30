class CreateMultiFamilies < ActiveRecord::Migration
  def change
    create_table :multi_families, :inherits => :listing do |t|
        t.string    :mf_type
        t.integer   :no_units
        t.integer   :no_floors
        t.integer   :total_rms
        t.integer   :garage_spaces
        t.integer   :parking_spaces
        t.integer   :lot_size
        t.integer   :acre 
        t.integer   :square_feet
        t.integer   :assessments

      t.timestamps
    end
  end
end
