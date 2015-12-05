# == Schema Information
#
# Table name: portals
#
#  id            :integer          not null, primary key
#  name          :string
#  url           :string
#  domain        :string
#  scraper_class :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  feed_url      :string
#

class Portal < ActiveRecord::Base
  has_many :positions

  validates :name, :url, :domain, presence: true

  before_validation :assign_domain

  def assign_domain
    self.domain = URI.parse(url).host.sub(/^www\./, '') if url.present?
  end

  def feed_url=(value)
    value = URI.parse(URI.encode(value.strip)) if value.present?
    write_attribute(:feed_url, value)
  end
end
