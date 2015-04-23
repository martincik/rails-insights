module Crawler
  module Position

    class GithubJobs < Base
      def run
        super
        page = html.css('#page .inner')

        @position.transaction do
          @position.company ||= Company.new do |company|
            company.name         = page.css('.column.sidebar .logo .inner h2').xpath('text()').text.squish.strip
            company.homepage_url = page.css('.column.sidebar .logo .url a').attr('href').value.strip
            company.logo_url     = page.css('.column.sidebar .logo img').attr('src').value.strip
          end

          @position.portal ||= @portal
          @position.title = page.css('h1').text.strip
          @position.kind, @position.location = page.css('.supertitle').text.split('/').map(&:strip)
          @position.description_text = page.css('.column.main').inner_text.strip
          @position.description_html = page.css('.column.main').inner_html.strip
          @position.how_to_apply = page.css('.column.sidebar .highlighted p').inner_html.strip

          @position.save(validate: false)
        end
      end
    end

  end
end
