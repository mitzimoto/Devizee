class CreateBizopps < ActiveRecord::Migration
  def change
    create_table :bizopps, :inherits => :listing do |t|
        t.string    :bu_type
        t.integer   :lot_sq_ft
        t.integer   :bldg_sq_feet
        t.integer   :parking_spcs
        t.string    :real_estate_incld

      t.timestamps
    end
  end
end
