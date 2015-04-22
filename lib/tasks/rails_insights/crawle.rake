namespace 'rails_insights' do

  namespace :crawle do
    desc 'Import model details using crawler'
    task all: [:positions] # list of tasks to run

    desc 'Import position details using crawler'
    task positions: :environment do
      verbose = ENV['VERBOSE'].present?
      logger  = Rails.logger

      Position.with_state(Position::STATE_PENDING).find_each do |position|
        begin
          crawler = Crawler::Position::Factory.new(position.domain).instance(position)
          crawler.run
          logger.info '.' if verbose
        rescue Crawler::UnknownPortalError, Crawler::UnknownCrawlerError => e
          logger.info 'x' if verbose
          logger.debug e.message
        end
      end
      logger.info 'DONE.' if verbose
    end
  end

end
