module Crawler
  module Position

    class GithubJobs < Base
      def run
        super
        page = html.css('#page .inner')

        @position.transaction do
          name_el     = page.css('.column.sidebar .logo .inner h2')
          homepage_el = page.css('.column.sidebar .logo .url a')
          logo_el     = page.css('.column.sidebar .logo img')
          name        = name_el.xpath('text()').text.squish.strip

          @position.portal ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = homepage_el.attr('href').value.strip if homepage_el.present?
          @position.company.logo_url = logo_el.attr('src').value.strip if logo_el.present?
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
