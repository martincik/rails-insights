ActiveAdmin.register Position do
  decorate_with PositionDecorator

  menu priority: 30
  actions :all, except: [:new]

  permit_params :identifier, :company_id, :portal_id, :title, :description, :how_to_apply, :url, :location, :salary, :kind, :type, :posted_at, :synchronized_at

  scope :all, default: true
  scope :pending      do |positions| positions.with_state(Position::STATE_PENDING) end
  scope :synchronized do |positions| positions.with_state(Position::STATE_SYNCHRONIZED) end

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
    column :state
    column :kind
    column :type
    column :posted_at
    column :synchronized_at
    column :created_at
    column :updated_at
    actions
  end

  # /admin/positions/:id/synchronize
  member_action :synchronize, method: :put do
    if resource.can_synchronize?
      resource.synchronize!
      redirect_to :back, notice: I18n.t("flash.positions.synchronize.notice", count: 1)
    else
      redirect_to :back, alert: I18n.t("flash.positions.synchronize.alert", count: 1)
    end
  end

  batch_action :synchronize do |ids|
    begin
      Position.where(id: ids).map(&:synchronize!)
      redirect_to :back, notice: I18n.t("flash.positions.synchronize.notice", count: ids.count)
    rescue StateMachine::InvalidTransition
      redirect_to :back, alert: I18n.t("flash.positions.synchronize.alert", count: ids.count)
    end
  end

  action_item :synchronize, only: [:show, :edit] do
    link_to("Synchronize", synchronize_admin_position_path(resource), method: :put) if resource.can_synchronize?
  end
end
