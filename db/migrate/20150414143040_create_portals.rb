class CreatePortals < ActiveRecord::Migration
  def change
    create_table :portals do |t|
      t.string :name
      t.string :url
      t.string :domain
      t.string :crawler_class

      t.timestamps null: false
    end
  end
end
