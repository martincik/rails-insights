module Scraper
  module Position

    class RailsJobs < Base
      def scrape!
        page = html.css('#job-listing')
        name = page.css('.content-well').first.css('h2 a').text.squish.strip.presence rescue nil

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('.content-well').first.css('h2 a').attr('href').value.strip.presence rescue nil
          @position.company.logo_url     = page.css('.job-logo a').attr('src').value.strip.presence rescue nil
          @position.description_text     = page.css('.job-listing-body').inner_text.strip
          @position.description_html     = page.css('.job-listing-body').inner_html.strip
          @position.how_to_apply         = page.css('a#apply-button').to_s.strip rescue nil
          @position.title                = page.css('.content-well').first.css('h1').text.strip.presence
          @position.location             = page.css('.job-location span span span').text.squish.strip.presence rescue nil
          @position.kind                 = page.css('.job-type span').text.squish.strip.presence rescue nil
          @position.save(validate: false)
        end
      end
    end

  end
end
