class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
        t.string    :short
        t.string    :long

      t.timestamps
    end
  end
end
