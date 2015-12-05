ActiveAdmin.register Portal do
  decorate_with PortalDecorator
  config.comments = false

  menu priority: 10
  actions :all

  permit_params :name, :url, :domain, :scraper_class, :feed_url

  index do
    selectable_column
    column :id do |portal| auto_link portal, portal.id end
    column :name
    column :homepage, sortable: :url
    column :scraper, sortable: :scraper_class do |portal| portal.scraper_implemented end
    column :created_at
    column :updated_at
    actions
  end

  sidebar :stats, only: :show do
    attributes_table_for portal do
      row :positions do link_to(portal.positions.size, admin_positions_path('q[portal_id_eq]' => portal.id)) end
    end
  end
end
