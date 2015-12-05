class AddFeedUrlToPortals < ActiveRecord::Migration
  def change
    add_column :portals, :feed_url, :string
  end
end
