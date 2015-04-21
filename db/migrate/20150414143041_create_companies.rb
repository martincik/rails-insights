class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :homepage_url
      t.string :homepage_domain
      t.string :logo_url

      t.timestamps null: false
    end
  end
end
