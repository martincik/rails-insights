ActiveAdmin.register Portal do
  decorate_with PortalDecorator
  # config.comments = false

  menu priority: 10
  actions :all

  permit_params :name, :url, :domain, :scraper_class, :feed_url

  index do
    selectable_column
    column :id do |portal| auto_link portal, portal.id end
    column :name
    column :homepage, sortable: :url
    column :feed_url, sortable: :feed_url do |portal| portal.feed_url(long: false) end
    column :scraper, sortable: :scraper_class do |portal| portal.scraper_implemented end
    column :created_at
    column :updated_at
    actions
  end

  sidebar :stats, only: :show do
    attributes_table_for portal do
      row :positions do link_to(portal.positions.size, admin_positions_path('q[portal_id_eq]' => portal.id)) end
    end
  end



  action_item :import_feed, only: :show, if: -> { resource.feed_url.present? } do
    link_to I18n.t("active_admin.buttons.portal.import_feed"), [:import_feed, :admin, resource], method: :put
  end

  member_action :import_feed, method: :put do
    begin
      count = Import::Feed::Positions.new(resource.object.feed_url).run
      redirect_to [:admin, resource], notice: I18n.t("flash.portals.import_feed.notice", count: count)
    rescue => exception
      Rollbar.error(exception)
      redirect_to :back, alert: I18n.t("flash.portals.import_feed.alert", reason: exception.message)
    end
  end
end
