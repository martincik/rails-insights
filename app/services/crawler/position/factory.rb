module Crawler
  module Position

    class Factory
      def initialize(domain)
        @domain = domain
        @portal = Portal.where("domain ILIKE ?", "%#{@domain}%").first

        raise ArgumentError, "Unable to find portal for domain #{@domain}" if @portal.nil?
      end

      def instance(position)
        @portal.crawler_class.camelize.constantize.new(position)
      end
    end

  end
end
