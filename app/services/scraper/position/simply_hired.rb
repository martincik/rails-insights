module Scraper
  module Position

    class SimplyHired < Base
      def scrape!
        page = html.css('#job_detail')
        name = page.css('table.info-table tr.company td:last').text.squish.strip.presence rescue nil

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('table.info-table tr.company td:last a').attr('href').value.strip.presence rescue nil
          # @position.company.logo_url     = page.css('table.info-table tr.company td:last img').attr('src').value.strip.presence rescue nil
          @position.description_text     = page.css('.job-description .description-full').inner_text.strip
          @position.description_html     = page.css('.job-description .description-full').inner_html.strip
          @position.how_to_apply         = page.css('.job-info a.btn').to_s.strip rescue nil
          @position.title                = page.css('.title h2').text.strip.presence
          @position.location             = page.css('table.info-table tr:nth-child(2) td:last').text.squish.strip.presence rescue nil
          @position.kind                 = 'remote' if @position.title.downcase.include?('remote')
          @position.save(validate: false)
        end
      end
    end

  end
end
