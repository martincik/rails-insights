module Crawler

  class CrawlerError < RuntimeError
  end

  class UnknownPortalError < CrawlerError
  end

  class UnknownCrawlerError < CrawlerError
  end

  class NotImplementedError < CrawlerError
  end

  class ContentNotPresentError < CrawlerError
  end

end
