module Crawler
  module Position

    class RubyWeekly < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
