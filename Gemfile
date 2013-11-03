source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
end

group :development, :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
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