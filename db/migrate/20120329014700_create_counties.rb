class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
        t.string    :short
        t.string    :long

      t.timestamps
    end
  end
end
