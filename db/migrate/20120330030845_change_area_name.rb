class ChangeAreaName < ActiveRecord::Migration
  def up
    rename_column :listings, :area_short, :area_code
  end

  def down
  end
end
