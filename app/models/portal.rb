# == Schema Information
#
# Table name: portals
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Portal < ActiveRecord::Base
  has_many :positions
end
