class ChangeAreaSymbol < ActiveRecord::Migration
  def up
    rename_column :listings, :area, :area_short
  end

  def down
  end
end
