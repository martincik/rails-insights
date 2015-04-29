module Crawler
  module Position

    class Weworkremotely < Base
      def crawle!
        page = html.css('.content')
        name = page.css('.listing-header-container .company').xpath('text()').text.squish.strip.presence rescue nil

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('.listing-header-container a').attr('href').value.strip rescue nil
          @position.company.logo_url     = page.css('.listing-logo img').attr('src').value.strip rescue nil
          @position.description_text     = page.css('.listing-container').inner_text.strip
          @position.description_html     = page.css('.listing-container').inner_html.strip
          @position.how_to_apply         = page.css('.apply').inner_html.strip
          @position.title                = page.css('.listing-header-container h1').text.strip.presence
          @position.location             = page.css('.listing-header-container .location').text.gsub('Headquarters: ', '').strip.presence
          @position.kind                 = 'remote'
          @position.save(validate: false)
        end
      end
    end

  end
end
