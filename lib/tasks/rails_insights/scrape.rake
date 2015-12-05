namespace 'rails_insights' do

  namespace :scrape do
    desc 'Import model details using scraper'
    task all: [:positions] # list of tasks to run

    desc 'Import position details using scraper'
    task positions: :environment do
      Position.without_state(Position::STATE_SYNCHRONIZED).find_each do |position|
        begin
          position.perform_synchronization! if position.can_perform_synchronization?
        rescue => exception
          Rollbar.error(exception)
          Rails.logger.debug(exception)
        end
      end
    end
  end

end
