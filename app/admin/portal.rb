ActiveAdmin.register Portal do
  decorate_with PortalDecorator

  menu priority: 10
  actions :all

  permit_params :name, :url
end
