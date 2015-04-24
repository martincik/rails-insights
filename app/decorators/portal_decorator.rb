class PortalDecorator < ApplicationDecorator
  delegate_all

  def homepage
    link_to_unless object.url.blank?, object.domain, object.url, target: '_blank' if object.url.present?
  end
end
