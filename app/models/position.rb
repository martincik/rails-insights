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
#  state            :string           default("pending")
#  kind             :string
#  type             :string
#  posted_at        :datetime
#  synchronized_at  :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Position < ActiveRecord::Base
  extend Enumerize

  STATE_PENDING = 'pending'
  STATE_SYNCHRONIZED = 'synchronized'

  def self.states
    [STATE_PENDING, STATE_SYNCHRONIZED]
  end

  enumerize :state, in: states, default: STATE_PENDING, predicates: false, scope: true


  alias_attribute :description, :description_text


  belongs_to :company
  belongs_to :portal


  state_machine initial: STATE_PENDING do
    state STATE_PENDING
    state STATE_SYNCHRONIZED

    event :synchronize
    event :reset

    transition on: :synchronize, from: STATE_PENDING, to: STATE_SYNCHRONIZED
    transition on: :reset, from: any, to: STATE_PENDING

    before_transition on: :synchronize do |p| p.synchronized_at = Time.zone.now end
    before_transition on: :reset       do |p| p.synchronized_at = nil end
  end


  def domain
    URI.parse(url).host.sub(/^www\./, '') if url.present?
  end
end
