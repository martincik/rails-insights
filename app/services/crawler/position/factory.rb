module Crawler
  module Position

    class Factory
      attr_reader :portal

      def initialize(domain)
        @portal = Portal.where("domain ILIKE ?", "%#{domain}%").first
        raise Crawler::UnknownPortalError, "Unable to find portal for domain #{domain}" if @portal.nil?
      end

      def instance(position)
        raise Crawler::UnknownCrawlerError, "Unknown crawler for portal #{@portal.name}" if @portal.crawler_class.nil?
        @portal.crawler_class.camelize.constantize.new(position, portal: @portal)
      end
    end

  end
end
