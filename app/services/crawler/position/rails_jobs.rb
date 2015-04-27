module Crawler
  module Position

    class RailsJobs < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
