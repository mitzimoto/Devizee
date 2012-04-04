class FixBeedroomColumn < ActiveRecord::Migration
  def up
      rename_column :sfprops, :no_beedrooms, :no_bedrooms
  end

  def down
      rename_column :sfprops, :no_bedrooms, :no_beedrooms
  end
end
