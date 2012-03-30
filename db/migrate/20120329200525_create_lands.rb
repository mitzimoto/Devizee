class CreateLands < ActiveRecord::Migration
  def change
    create_table :lands, :inherits => :listing do |t|
        t.string    :ld_type
        t.integer   :lot_size
        t.integer   :acre

      t.timestamps
    end
  end
end
