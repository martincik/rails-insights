class PortalDecorator < ApplicationDecorator
  delegate_all

  def homepage
    link_to_unless object.url.blank?, object.domain, object.url, target: '_blank' if object.url.present?
  end

  def scraper_implemented
    check_box_tag nil, nil, object.scraper_class.present?, disabled: true
  end

  def feed_url(long: false)
    link_to long ? object.feed_url : icon('external-link'), object.feed_url, target: '_blank' if object.feed_url.present?
  end
end
