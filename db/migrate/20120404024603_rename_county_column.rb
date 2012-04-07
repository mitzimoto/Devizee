class RenameCountyColumn < ActiveRecord::Migration
  def up
      rename_column :towns, :county, :county_short
  end

  def down
      rename_column :towns, :county_short, :county
  end
end
