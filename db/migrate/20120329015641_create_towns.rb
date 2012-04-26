class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string  :num
      t.string  :long
      t.string  :county
      t.string  :state
      t.timestamps
    end
  end
end