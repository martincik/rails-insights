ActiveAdmin.register Portal do
  decorate_with PortalDecorator

  menu priority: 10
  actions :all

  permit_params :name, :url, :domain, :crawler_class

  index do
    selectable_column
    column :id do |portal| auto_link portal, portal.id end
    column :name
    column :url
    column :domain
    column :created_at
    column :updated_at
    actions
  end
end
