require 'open-uri'
require 'rss'
require 'htmlentities'

module Import
  module Feed

    class Positions
      class Sanitizer
        include ActionView::Helpers::SanitizeHelper
      end

      def initialize(feed_url)
        @feed_url = feed_url
      end

      def run
        Position.transaction do
          rss.items.reverse.each do |item|
            position = Position.where(url: item.link).first_or_initialize
            if position.new_record?
              position.title = sanitize(item.title)
              position.description_text = sanitize(item.description)
              position.description_html = item.description
              position.posted_at = item.date
              position.save(validate: false)
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

      def sanitizer
        @sanitizer ||= Sanitizer.new
      end

      private

      #  scrub text of undesired HTML elements
      def sanitize(text)
        HTMLEntities.new.decode(sanitizer.strip_tags(text)).squish.strip
      end
    end

  end
end
