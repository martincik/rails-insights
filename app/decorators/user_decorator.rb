class UserDecorator < ApplicationDecorator
  delegate_all

  def email
    mail_to object.email if object.email.present?
  end
end
