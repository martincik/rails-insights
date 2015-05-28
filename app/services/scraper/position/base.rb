require 'httparty'
require 'nokogiri'

module Scraper
  module Position

    class Base
      attr_reader :position, :portal, :logger

      def initialize(position, portal: nil, logger: Rails.logger)
        @position = position
        @portal = portal
        @logger = logger
      end

      def run
        begin
          raise Scraper::ContentNotPresentError, "Unable to find desired content at URL: #{postion.url}" unless html.respond_to?(:css)
          position.begin! # mark sync as started
          scrape!
          position.finish! # mark sync as finished

        rescue Scraper::ScraperError => exception
          position.failure! # mark sync as failed
          logger.debug(exception.message)
          raise exception # re-raise exception
        end
      end

      def scrape!
        raise Scraper::NotImplementedError
      end

      def response
        @response ||= HTTParty.get(@position.url)
      end

      def html
        @html ||= dom(response.body)
      rescue SocketError => e
        logger.error "Error HTTParty: #{e.message}"
      end

      protected

      def dom(html)
        Nokogiri::HTML(html)
      end
    end

  end
end
