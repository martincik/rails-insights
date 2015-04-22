namespace 'rails_insights' do

  namespace :crawle do
    desc 'Import model details using crawler'
    task all: [:positions] # list of tasks to run

    desc 'Import position details using crawler'
    task positions: :environment do
      Position.with_state(Position::STATE_PENDING).find_each.map(&:synchronize!)
    end
  end

end
