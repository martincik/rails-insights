class Position < ActiveRecord::Base
  belongs_to :company
  belongs_to :portal

  alias_attribute :description, :description_text

  state_machine initial: :pending do
    state :pending
    state :synchronized

    event :synchronize
    event :reset

    transition on: :synchronize, from: :pending, to: :synchronized
    transition on: :reset, from: any, to: :pending

    after_transition on: :synchronize do |p| p.synchronized_at = Time.zone.now end
    after_transition on: :reset       do |p| p.synchronized_at = nil end
  end
end
