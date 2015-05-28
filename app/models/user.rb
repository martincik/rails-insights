# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string           default(""), not null
#  email               :string           default(""), not null, indexed
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  scope :last_logged_in, -> { where.not(current_sign_in_at: nil).order(current_sign_in_at: :desc).limit(10) }
end
