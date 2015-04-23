require 'httparty'
require 'nokogiri'

module Crawler
  module Position

    class Base
      attr_reader :position, :portal, :logger

      def initialize(position, portal: nil, logger: Rails.logger)
        @position = position
        @portal = portal
        @logger = logger
      end

      def run
        return unless html.respond_to?(:css)
      end

      def responce
        @responce ||= HTTParty.get(@position.url)
      end

      def html
        @html ||= dom(responce.body)
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
