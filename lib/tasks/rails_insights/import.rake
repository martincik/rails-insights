namespace 'rails_insights' do

  namespace :import do

    namespace :feed do
      desc 'Import data from RSS feed'
      task all: [:positions] # list of tasks to run

      desc 'Import positions from RSS feed'
      task positions: :environment do
        feed_url = Rails.application.secrets.import_feed_url.presence
        import = Import::Feed::Positions.new(feed_url)
        import.run
      end
    end

  end

end
