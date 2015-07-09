ruby '2.1.5'
source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '~> 4.2'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'devise'
gem 'activeadmin', '~> 1.0.0.pre'
gem 'draper'
gem 'enumerize'
gem 'state_machine'
gem 'font-awesome-sass'
gem 'htmlentities', require: false
gem 'httparty', require: false
gem 'nokogiri', require: false
gem 'newrelic_rpm'

# asset gems
gem 'rails-assets-selectize'

group :development, :test do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'byebug'
end

group :development do
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'annotate'
  gem 'hirb', require: false
end

group :production, :staging do
  gem 'unicorn'
  gem 'rails_12factor'
end
