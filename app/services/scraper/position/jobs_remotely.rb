module Scraper
  module Position

    class JobsRemotely < Base
      def scrape!
        page = html.css('body')
        name = page.css('.well.col-sm-4 .col-sm-12 h3 a').xpath('text()').text.squish.strip.presence rescue nil

        @position.transaction do
          if name.present? # sometimes client info is not present
            @position.company ||= Company.where(name: name).first_or_create!
            @position.company.homepage_url = page.css('.well.col-sm-4 .col-sm-12:nth-child(2) a').attr('href').value.strip.presence rescue nil
            @position.company.logo_url     = page.css('.well.col-sm-4 .col-sm-12:nth-child(1) img').attr('src').value.strip.presence rescue nil
          end

          @position.portal  ||= @portal
          @position.description_text     = page.css('.well.col-sm-8 .col-sm-12').first.inner_text.strip
          @position.description_html     = page.css('.well.col-sm-8 .col-sm-12').first.inner_html.strip
          @position.how_to_apply         = page.css('.well.col-sm-8 .col-sm-12').last.inner_html.strip
          @position.title                = page.css('.jumbotron .text-center h1').text.strip.presence
          @position.location             = page.css('.jumbotron .text-center small').text.split('/').last.gsub('location', '').strip.presence rescue nil
          @position.save(validate: false)
        end
      end
    end

  end
end
