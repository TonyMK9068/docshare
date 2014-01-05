source 'https://rubygems.org'
gem 'rails', '3.2.13'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'brakeman', :require => false
end

group :development, :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'simplecov'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'skeleton-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'thin'
gem 'devise'
gem 'figaro'
gem 'redcarpet'
gem 'marked-rails'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'cancan'
gem 'faker'
gem "friendly_id", "~> 4.0.10"
gem 'paper_trail', '>= 3.0.0.rc1'
gem 'devise_security_extension'
gem 'rails_email_validator'