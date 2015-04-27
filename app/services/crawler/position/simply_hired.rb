module Crawler
  module Position

    class SimplyHired < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
