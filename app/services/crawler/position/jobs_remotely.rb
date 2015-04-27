module Crawler
  module Position

    class JobsRemotely < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
