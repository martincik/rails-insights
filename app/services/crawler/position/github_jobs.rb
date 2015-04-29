module Crawler
  module Position

    class GithubJobs < Base
      def crawle!
        page = html.css('#page .inner')
        name = page.css('.column.sidebar .logo .inner h2').xpath('text()').text.squish.strip.presence rescue nil

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('.column.sidebar .logo .url a').attr('href').value.strip.presence rescue nil
          @position.company.logo_url     = page.css('.column.sidebar .logo img').attr('src').value.strip.presence rescue nil
          @position.description_text     = page.css('.column.main').inner_text.strip
          @position.description_html     = page.css('.column.main').inner_html.strip
          @position.how_to_apply         = page.css('.column.sidebar .highlighted p').inner_html.strip
          @position.title                = page.css('h1').text.strip.presence
          @position.kind, @position.location = page.css('.supertitle').text.split('/').map(&:strip).map(&:presence)
          @position.save(validate: false)
        end
      end
    end

  end
end
