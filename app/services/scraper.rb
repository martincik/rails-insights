module Scraper

  class ScraperError < RuntimeError
  end

  class UnknownPortalError < ScraperError
  end

  class UnknownScraperError < ScraperError
  end

  class NotImplementedError < ScraperError
  end

  class ContentNotPresentError < ScraperError
  end

end
