class CreateCondos < ActiveRecord::Migration
  def change
    create_table :condos, :inherits => :listing do |t|
        t.string    :cc_type
        t.integer   :no_living_levels
      t.timestamps
    end
  end
end
