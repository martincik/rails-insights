require 'open-uri'
require 'rss'
require 'htmlentities'

module Import
  module Feed

    class Positions
      def initialize(feed_url)
        @feed_url = feed_url
      end

      def run
        Position.transaction do
          rss.items.reverse.each do |item|
            position = Position.where(url: item.link).first_or_initialize
            if position.new_record?
              position.title = sanitize(item.title)
              position.description = sanitize(item.description)
              position.posted_at = item.date
              position.save! if position.title.present? && position.description.present?
            end
          end
        end
      end

      protected

      def rss
        @rss ||= RSS::Parser.parse(feed, false)
      end

      def feed
        @feed ||= open(@feed_url).read
      end

      def sanitize(text)
        HTMLEntities.new.decode(text).squish.strip
      end
    end

  end
end
