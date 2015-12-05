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
          feed.entries.reverse.each do |entry|
            position = Position.where(url: entry.url).first_or_initialize
            if position.new_record?
              position.title = sanitize(entry.title)
              position.description_text = sanitize(entry.summary || entry.content)
              position.description_html = entry.summary || entry.content
              position.posted_at = entry.published || entry.updated
              position.save(validate: false) if position.related_to?('rails') || position.related_to?('ruby')
            end
          end
        end
      end

      protected

      def feed
        @feed ||= Feedjira::Feed.fetch_and_parse(@feed_url)
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
