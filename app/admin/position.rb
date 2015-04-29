ActiveAdmin.register Position do
  decorate_with PositionDecorator

  menu priority: 30
  actions :all, except: [:new]

  permit_params :identifier, :company_id, :portal_id, :title, :description, :how_to_apply, :url, :location, :salary, :kind, :type, :posted_at, :synchronized_at

  scope :all, default: true
  scope :pending      do |positions| positions.with_state(Position::STATE_PENDING) end
  scope :failed       do |positions| positions.with_state(Position::STATE_FAILED) end
  scope :synchronized do |positions| positions.with_state(Position::STATE_SYNCHRONIZED) end

  index do
    selectable_column
    column :id do |position| auto_link position, position.id end
    column :identifier
    column :title
    column :location
    column :salary
    column :state
    column :kind
    column :posted_at
    column :synchronized_at
    column :created_at
    column :updated_at
    column :url
    actions
  end

  show do
    attributes_table do
      row :identifier
      row :title
      row :description_html do |position| raw(position.description_html) end
      row :how_to_apply     do |position| raw(position.how_to_apply) end
      row :url do |position| position.url(long: true) end
      row :location
      row :salary
      row :state
      row :kind
      row :type
      row :posted_at
      row :synchronized_at
      row :created_at
      row :updated_at
    end
  end

  sidebar :company, only: :show, if: -> { position.company.present? } do
    attributes_table_for position.company.decorate do
      row :name do |company| auto_link company, company.name end
      row :homepage
      row :logo_image
    end
  end

  sidebar :portal, only: :show, if: -> { position.portal.present? } do
    attributes_table_for position.portal.decorate do
      row :name do |portal| auto_link portal, portal.name end
      row :homepage, sortable: :url
    end
  end

  action_item :synchronize, only: [:show, :edit] do
    link_to 'Synchronize', synchronize_admin_position_path(resource), method: :put if resource.can_perform_synchronization?
  end

  member_action :synchronize, method: :put do
    resource.perform_synchronization! if resource.can_perform_synchronization?

    if resource.synchronized?
      redirect_to :back, notice: I18n.t('flash.positions.synchronize.notice', count: 1)
    else
      redirect_to :back, alert: I18n.t('flash.positions.synchronize.alert', count: 1, reason: 'Crawler raised an exception')
    end
  end

  batch_action :synchronize do |ids|
    begin
      Position.where(id: ids).map(&:perform_synchronization!)
      redirect_to :back, notice: I18n.t('flash.positions.synchronize.notice', count: ids.count)
    rescue StateMachine::InvalidTransition, Crawler::CrawlerError => e
      redirect_to :back, alert: I18n.t('flash.positions.synchronize.alert', count: ids.count, reason: e.message)
    end
  end

  collection_action :crawle, method: :post do
    ids = Position.with_state(Position::STATE_PENDING).limit(15).ids
    begin
      Position.where(id: ids).map(&:perform_synchronization!)
      redirect_to :back, notice: I18n.t('flash.positions.synchronize.notice', count: ids.count)
    rescue StateMachine::InvalidTransition, Crawler::CrawlerError => e
      redirect_to :back, alert: I18n.t('flash.positions.synchronize.alert', count: ids.count, reason: e.message)
    end
  end
end
