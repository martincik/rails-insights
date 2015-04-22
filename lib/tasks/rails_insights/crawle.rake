namespace 'rails_insights' do

  namespace :crawle do
    desc 'Import data from RSS feed'
    task all: [:positions] # list of tasks to run

    desc 'Import positions from RSS feed'
    task positions: :environment do
      verbose = ENV['VERBOSE'].present?
      logger  = Rails.logger

      Position.with_state(Position::STATE_PENDING).find_each do |position|
        begin
          crawler = Crawler::Position::Factory.new(position.domain).instance(position)
          crawler.run
          print '.' if verbose
        rescue Crawler::UnknownPortalError, Crawler::UnknownCrawlerError => e
          print 'x' if verbose
          logger.debug e.message
        end
      end
      puts 'DONE.' if verbose
    end
  end

end
