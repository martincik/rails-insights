class SyncPositionJob < ActiveJob::Base
  queue_as :default

  def perform(position, logger: Rails.logger)
    begin
      crawler = Crawler::Position::Factory.new(position.domain).instance(position)
      crawler.run
    rescue Crawler::CrawlerError => e
      logger.debug(e.message)
      position.fail! # mark sync as failed
    end
  end
end
