class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
        t.string    :code
        t.string    :name
        t.string    :phone
        
      t.timestamps
    end
  end
end
