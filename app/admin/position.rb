ActiveAdmin.register Position do
  decorate_with PositionDecorator

  menu priority: 30
  actions :all, except: [:new]

  permit_params :identifier, :company_id, :portal_id, :title, :description, :how_to_apply, :url, :location, :salary, :kind, :type, :posted_at, :synchronized_at
end
