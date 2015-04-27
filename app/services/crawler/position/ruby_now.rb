module Crawler
  module Position

    class RubyNow < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
