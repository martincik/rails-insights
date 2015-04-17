ActiveAdmin.register Position do
  decorate_with PositionDecorator

  menu priority: 30
  actions :all, except: [:new]

  permit_params :identifier, :company_id, :portal_id, :title, :description, :how_to_apply, :url, :location, :salary, :kind, :type, :posted_at, :synchronized_at

  index do
    selectable_column
    column :id do |position| auto_link position, position.id end
    column :identifier
    column :title
    column :description, sortable: :description_text
    column :how_to_apply
    column :url
    column :location
    column :salary
    column :kind
    column :type
    column :posted_at
    column :synchronized_at
    column :created_at
    column :updated_at
    actions
  end
end
