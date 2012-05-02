class ListIdToInt < ActiveRecord::Migration
  def up
      change_column :listings, :list_no, :integer
  end

  def down
      change_column :listings, :list_no, :string
  end
end
