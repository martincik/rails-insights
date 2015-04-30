ActiveAdmin.register User do
  decorate_with UserDecorator
  config.comments = false

  menu priority: 100
  actions :all, except: [:new]

  permit_params :name, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email

      # Timestampable
      row :created_at
      row :updated_at
    end

    panel I18n.t("active_admin.panels.login_details"), collapsed: true do
      attributes_table_for user.decorate do
        # trackable
        row :current_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_at
        row :last_sign_in_ip
        row :sign_in_count

        # rememberable
        row :remember_created_at
      end
    end
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs :user_details do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
