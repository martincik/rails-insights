ActiveAdmin.register Company do
  decorate_with CompanyDecorator

  menu priority: 20
  actions :all, except: [:new]

  permit_params :name, :homepage_domain, :homepage_url, :logo_url

  index do
    selectable_column
    column :id do |company| auto_link company, company.id end
    column :logo_image, sortable: :logo_url
    column :name
    column :homepage, sortable: :homepage_url
    column :created_at
    column :updated_at
    actions
  end
end
