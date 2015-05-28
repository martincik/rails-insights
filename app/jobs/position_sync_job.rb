class PositionSyncJob < ActiveJob::Base
  queue_as :default

  rescue_from(Scraper::ScraperError) do |exception|
    Rails.logger.debug(exception.message)
    @position.failure!
  end

  def perform(position)
    @position = position
    scraper = Scraper::Position::Factory.new(@position).instance
    scraper.run
  end
end
