module Crawler
  module Position

    class StackOverflowCareers < Base
      def run
        super
        page = html.css('#jobdetailpage')
        name = page.css('a.employer').xpath('text()').text.squish.strip

        @position.transaction do
          @position.portal  ||= @portal
          @position.company ||= Company.where(name: name).first_or_create!
          @position.company.homepage_url = page.css('a.employer').attr('href').value.strip rescue nil
          @position.company.logo_url     = page.css('.company .-logo img').attr('src').value.strip rescue nil
          @position.description_text     = page.css('.h4, .description').inner_text.strip
          @position.description_html     = page.css('.h4, .description').inner_html.strip
          @position.how_to_apply         = 'Apply using StackOverflow'
          @position.title                = page.css('.jobdetail h1').text.strip
          @position.location             = page.css('.jobdetail .location').text.gsub(' (allows remote)', '').strip
          @position.kind                 = 'remote' if page.css('.jobdetail .location').text.downcase.include?('remote')
          @position.save(validate: false)
        end
      end
    end

  end
end
