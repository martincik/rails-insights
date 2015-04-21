# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string
#  homepage_url    :string
#  homepage_domain :string
#  logo_url        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Company < ActiveRecord::Base
  has_many :positions

  validates :name, :homepage_url, :homepage_domain, presence: true

  before_validation :assign_homepage_domain

  def assign_homepage_domain
    self.homepage_domain = URI.parse(homepage_url).host.sub(/^www\./, '') if homepage_url.present?
  end
end
