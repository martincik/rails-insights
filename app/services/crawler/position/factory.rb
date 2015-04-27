module Crawler
  module Position

    class Factory
      attr_reader :position

      def initialize(position)
        @position = position
      end

      def instance
        raise Crawler::UnknownPortalError, "Unable to find portal for domain #{position.domain}" if portal.nil?
        raise Crawler::UnknownCrawlerError, "Unknown crawler for portal #{portal.name}" if portal.crawler_class.nil?
        @portal.crawler_class.camelize.constantize.new(position, portal: portal)
      end

      protected

      def portal
        @portal ||= (position.portal || Portal.where("domain ILIKE ?", "%#{position.domain}%").first)
      end
    end

  end
end
