ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  action_item :heroku do
    link_to "Heroku", "https://dashboard.heroku.com/apps/rails-insights/resources", target: '_new'
  end

  action_item :crawle do
    link_to "Run crawler", crawle_admin_positions_path, method: :post
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel I18n.t("active_admin.panels.last_logged_in_users") do
          table_for User.last_logged_in.decorate, i18n: User do
            column :name do |user| auto_link user end
            column :current_sign_in_at
          end
        end
      end

      column do
        panel I18n.t("active_admin.panels.last_comments")  do
          table_for ActiveAdmin::Comment.order(created_at: :desc).limit(10) do
            column :created_at
            column :resource
            column :author
            column do |comment| truncate comment.body end
          end
        end
      end

      column do
        panel I18n.t("active_admin.panels.last_failed_synchronizations")  do
          table_for Position.last_failed.decorate, i18n: Position do
            column :id do |position| auto_link position, position.id end
            column :title
            column :domain
            column :url
          end
        end
      end if Position.last_failed.any?
    end
  end
end
