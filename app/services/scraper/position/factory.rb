module Scraper
  module Position

    class Factory
      attr_reader :position

      def initialize(position)
        @position = position
      end

      def instance
        raise Scraper::UnknownPortalError, "Unable to find portal for domain #{position.domain}" if portal.nil?
        raise Scraper::UnknownScraperError, "Unknown scraper for portal #{portal.name}" if portal.scraper_class.nil?
        @portal.scraper_class.camelize.constantize.new(position, portal: portal)
      end

      protected

      def portal
        @portal ||= (position.portal || Portal.where("domain ILIKE ?", "%#{position.domain}%").first)
      end
    end

  end
end
