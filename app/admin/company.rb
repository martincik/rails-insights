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

  show do
    attributes_table do
      row :id
      row :name
      row :homepage
      row :logo_image
      row :created_at
      row :updated_at
    end

    panel "Positions" do
      table_for company.positions.decorate, i18n: Position do
        column :id do |position| auto_link position, position.id end
        column :identifier
        column :title
        column :url
        column :location
        column :salary
        column :state
        column :kind
        column :posted_at
        column :synchronized_at
      end
    end if company.positions.any?
  end

end
