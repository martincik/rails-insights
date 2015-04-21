# == Schema Information
#
# Table name: portals
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  domain     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Portal < ActiveRecord::Base
  has_many :positions

  validates :name, :url, :domain, presence: true

  before_validation :assign_domain

  def assign_domain
    self.domain = URI.parse(url).host.sub(/^www\./, '') if url.present?
  end
end
