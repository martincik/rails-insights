module Crawler
  module Position

    class Odesk < Base
      def run
        super
        raise Crawler::NotImplementedError
      end
    end

  end
end
