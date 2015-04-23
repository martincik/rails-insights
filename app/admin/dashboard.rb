ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  action_item :heroku do
    link_to "Heroku", "https://dashboard.heroku.com/apps/rails-insights/resources", target: '_new'
  end

  action_item :crawle do
    link_to "Run crawler", crawle_admin_positions_path, method: :post
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end
end
