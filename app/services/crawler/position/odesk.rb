module Crawler
  module Position

    class Odesk < Base
      def crawle!
        page = html.css('article.oJob')
        name = page.css('.oClientFacts .oTitle a').text.strip.presence rescue nil

        @position.transaction do
          if name.present? # sometimes client info is not present
            @position.company ||= Company.where(name: name).first_or_create!
            @position.company.homepage_url = page.css('.oClientFacts .oTitle a').attr('href').value.gsub('/leaving_odesk.php?ref=', '').strip.presence rescue nil
            @position.company.logo_url     = page.css('.oClientFacts .oClientAvatar img').attr('src').value.strip.presence rescue nil
          end

          @position.portal ||= @portal
          @position.description_text     = page.css('.oDescriptionWrapper').inner_text.strip
          @position.description_html     = page.css('.oDescriptionWrapper').inner_html.strip
          @position.how_to_apply         = 'Apply using oDesk'
          @position.title                = page.css('.oJobInfo h1').text.strip.presence
          @position.location             = 'Home office'
          @position.kind                 = 'remote' if @position.description_text.include?('remote').presence
          @position.save(validate: false)
        end
      end
    end

  end
end
