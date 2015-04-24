class CompanyDecorator < ApplicationDecorator
  delegate_all

  def homepage
    link_to_unless object.homepage_url.blank?, object.homepage_domain, object.homepage_url, target: '_blank' if object.homepage_url.present?
  end

  def logo_image
    image_tag object.logo_url, width: 64 if object.logo_url.present?
  end
end
