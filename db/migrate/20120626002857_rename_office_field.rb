class RenameOfficeField < ActiveRecord::Migration
  def up
      rename_column :listings, :list_office, :office_code
  end

  def down
      rename_column :listings, :office_code, :list_office
  end
end
