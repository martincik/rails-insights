class PositionSyncJob < ActiveJob::Base
  queue_as :default

  rescue_from(Crawler::CrawlerError) do |exception|
    Rails.logger.debug(exception.message)
    @position.failure!
  end

  def perform(position)
    @position = position
    crawler = Crawler::Position::Factory.new(@position).instance
    crawler.run
  end
end
