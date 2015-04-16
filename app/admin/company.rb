ActiveAdmin.register Company do
  decorate_with CompanyDecorator

  menu priority: 20
  actions :all, except: [:new]

  permit_params :name, :homepage_url, :logo_url
end
