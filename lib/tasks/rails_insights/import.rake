namespace 'rails_insights' do

  namespace :import do

    namespace :feed do
      desc 'Import data from RSS feed'
      task all: [:positions] # list of tasks to run

      desc 'Import positions from RSS feed'
      task positions: :environment do
        Portal.where.not(feed_url: nil).find_each(batch_size: 5) do |portal|
          begin
            import = Import::Feed::Positions.new(portal.feed_url)
            import.run
          rescue => exception
            Rollbar.error(exception)
            Rails.logger.debug(exception)
          end
        end
      end
    end

  end

end
