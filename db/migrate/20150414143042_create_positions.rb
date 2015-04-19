class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :identifier
      t.references :company, index: true
      t.references :portal, index: true
      t.string :title
      t.text :description_html
      t.text :description_text
      t.text :how_to_apply
      t.string :url
      t.string :location
      t.string :salary
      t.string :state
      t.string :kind
      t.string :type
      t.datetime :posted_at
      t.datetime :synchronized_at

      t.timestamps null: false
    end
    add_foreign_key :positions, :companies
    add_foreign_key :positions, :portals
  end
end
