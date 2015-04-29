module Crawler
  module Position

    class RubyNow < Base
      def crawle!
        page = html.css('#job')
        name = page.css('h2#headline a').text.squish.strip.presence rescue nil

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('h2#headline a').attr('href').value.strip.presence rescue nil
          # @position.company.logo_url     = page.css('.job-logo img').attr('src').value.strip.presence rescue nil
          @position.description_text     = page.css('#info').inner_text.strip
          @position.description_html     = page.css('#info').inner_html.strip
          @position.how_to_apply         = page.css('#show_application_instructions').to_s.strip rescue nil
          @position.title                = page.css('h2#headline').xpath('text()').text.squish.strip.presence
          @position.location             = page.css('h3#location').text.squish.strip.presence rescue nil
          # @position.kind                 = page.css('.job-type span').text.squish.strip.presence rescue nil
          @position.save(validate: false)
        end
      end
    end

  end
end
