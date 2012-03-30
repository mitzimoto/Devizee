class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
        t.integer   :sf
        t.integer   :cc 
        t.integer   :mf
        t.integer   :ld
        t.integer   :ci 
        t.integer   :bu
        t.integer   :m 
        t.string    :field
        t.string    :short
        t.string    :medium
        t.string    :long

      t.timestamps
    end
  end
end
