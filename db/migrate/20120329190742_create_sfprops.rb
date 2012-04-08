class CreateSfprops < ActiveRecord::Migration
  def change
    create_table :sfprops, :inherits => :listing do |t|
        
        t.string    :sf_type

      t.timestamps
    end
  end
end
