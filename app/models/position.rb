# == Schema Information
#
# Table name: positions
#
#  id               :integer          not null, primary key
#  identifier       :string
#  company_id       :integer          indexed
#  portal_id        :integer          indexed
#  title            :string
#  description_html :text
#  description_text :text
#  how_to_apply     :text
#  url              :string
#  location         :string
#  salary           :string
#  visibility       :string
#  state            :string           default("pending")
#  kind             :string
#  type             :string
#  posted_at        :datetime
#  synchronized_at  :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  archived_at      :datetime
#

class Position < ActiveRecord::Base
  extend Enumerize

  STATE_PENDING = 'pending'
  STATE_FAILED = 'failed'
  STATE_SYNCHRONIZING = 'synchronizing'
  STATE_SYNCHRONIZED = 'synchronized'

  def self.states
    [STATE_PENDING, STATE_FAILED, STATE_SYNCHRONIZING, STATE_SYNCHRONIZED]
  end

  enumerize :state, in: states, default: STATE_PENDING, predicates: false, scope: true


  VISIBILITY_PUBLIC  = 'public'
  VISIBILITY_PRIVATE = 'private'

  def self.visibilities
    [VISIBILITY_PUBLIC, VISIBILITY_PRIVATE]
  end

  enumerize :visibility, in: visibilities, default: VISIBILITY_PUBLIC, predicates: true, scope: true


  alias_attribute :description, :description_text


  belongs_to :company, autosave: true
  belongs_to :portal


  scope :last_failed, -> { with_state(STATE_FAILED).order(created_at: :desc) }


  state_machine initial: STATE_PENDING do
    state STATE_PENDING
    state STATE_FAILED
    state STATE_SYNCHRONIZING
    state STATE_SYNCHRONIZED

    event :begin
    event :finish
    event :failure
    event :reset

    transition on: :begin,   from: any, to: STATE_SYNCHRONIZING
    transition on: :finish,  from: any, to: STATE_SYNCHRONIZED
    transition on: :failure, from: any, to: STATE_FAILED
    transition on: :reset,   from: any, to: STATE_PENDING

    after_failure on: :begin, do: :failure!
    before_transition on: [:failure, :reset] do |p| p.synchronized_at = nil end
    before_transition on: :finish  do |p| p.synchronized_at = Time.zone.now end
  end


  def domain
    URI.parse(url).host.sub(/^www\./, '') if url.present?
  end

  def kind=(value)
    value = value.humanize.downcase if value.present?
    write_attribute(:kind, value.presence)
  end

  def perform_synchronization!
    PositionSyncJob.perform_later(self)
  end

  alias_method :can_perform_synchronization?, :can_begin?
end
