namespace 'rails_insights' do
  desc 'Alias for seed:all'
  task seed: 'seed:all'

  namespace :seed do
    desc 'Seed default data into database'
    task all: [:portals] # list of tasks to run

    desc 'Seed default portals into database'
    task portals: :environment do
      Portal.transaction do
        portals = YAML.load_file("#{Rails.root}/db/default/portals.yml")
        portals.each do |symbol, hash|
          Portal.create!(hash)
        end
      end
    end
  end
end

# alias task db:seed with rails_insights:seed:all
Rake::Task["db:seed"].enhance(["rails_insights:seed:all"])
