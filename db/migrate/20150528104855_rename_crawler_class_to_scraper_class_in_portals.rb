class RenameCrawlerClassToScraperClassInPortals < ActiveRecord::Migration
  def change
    rename_column :portals, :crawler_class, :scraper_class
  end
end
