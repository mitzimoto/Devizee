class CreateCommercials < ActiveRecord::Migration
  def change
    create_table :commercials, :inherits => :listing do |t|
        t.string    :ci_type
        t.string    :space_available
        t.integer   :rsu_units
        t.integer   :rsf_bldg_sf
        t.integer   :ofu_units
        t.integer   :off_bldg_sf
        t.integer   :reu_units
        t.integer   :ref_bldg_sf
        t.integer   :wau_units
        t.integer   :waf_bldg_sf
        t.integer   :mau_units
        t.integer   :maf_bldg_sf
        t.integer   :total_units
        t.integer   :total_bldg_sf
        t.integer   :lot_size
        t.integer   :acre 
        t.integer   :parking_spcs

      t.timestamps
    end
  end
end
