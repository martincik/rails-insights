module Crawler
  module Position

    class Factory
      def initialize(domain)
        @domain = domain
        @portal = Portal.where("domain ILIKE ?", "%#{@domain}%").first
        raise Crawler::UnknownPortalError, "Unable to find portal for domain #{@domain}" if @portal.nil?
      end

      def instance(position)
        raise Crawler::UnknownCrawlerError, "Unknown crawler for portal #{@portal.name}" if @portal.crawler_class.nil?
        @portal.crawler_class.camelize.constantize.new(position)
      end
    end

  end
end
