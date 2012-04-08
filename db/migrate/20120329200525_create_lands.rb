class CreateLands < ActiveRecord::Migration
  def change
    create_table :lands, :inherits => :listing do |t|
        t.string    :ld_type
      t.timestamps
    end
  end
end
