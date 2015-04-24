module Crawler
  module Position

    class StackOverflowCareers < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
