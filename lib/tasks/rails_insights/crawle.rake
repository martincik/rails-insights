namespace 'rails_insights' do

  namespace :crawle do
    desc 'Import data from RSS feed'
    task all: [:positions] # list of tasks to run

    desc 'Import positions from RSS feed'
    task positions: :environment do
      verbose = ENV['VERBOSE'].present?

      Position.pending.find_each do |position|
        crawler = Crawler::Position::Factory.new(position.domain).instance(position)
        crawler.run
        print '.' if verbose
      end
      puts 'DONE.' if verbose
    end
  end

end
