module Crawler
  module Position

    class Indeed < Base
      def crawle!
        page = html.css('table:last tr:first')
        name = page.css('.cmp_info .cmp_title').text.squish.strip.presence rescue nil

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('.cmp_info .cmp_title').attr('href').value.strip rescue nil
          @position.company.logo_url     = page.css('.cmp_info img').attr('src').value.strip rescue nil
          @position.description_text     = page.css('#job_summary').inner_text.strip
          @position.description_html     = page.css('#job_summary').inner_html.strip
          @position.how_to_apply         = "Apply via indeed.com"
          @position.title                = page.css('#job_header .jobtitle').text.strip.presence
          @position.location             = page.css('#job_header .location').text.strip.presence
          # @position.kind                 = 'remote'
          @position.save(validate: false)
        end
      end
    end

  end
end
