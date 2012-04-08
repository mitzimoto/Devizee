class CreateMobileHomes < ActiveRecord::Migration
  def change
    create_table :mobile_homes, :inherits => :listing do |t|
      t.timestamps
    end
  end
end
