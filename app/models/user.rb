class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  scope :last_logged_in, -> { where.not(current_sign_in_at: nil).order(current_sign_in_at: :desc).limit(10) }
end
