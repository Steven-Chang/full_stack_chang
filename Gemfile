# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'activeadmin'
gem 'binance'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cloudinary'
gem 'devise'
# Barebones two-factor authentication with Devise
gem 'devise-two-factor'
gem 'haml'
# Foreign key migration generator for Rails
gem 'immigrant'
# Build JSON APIs with ease. Read more: httgem 'puma', '~> 3.11's://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# https://github.com/sparklemotion/mechanize
gem 'mechanize'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
# Monitoring the app
# https://rpm.newrelic.com/accounts/2222353/applications/setup#ruby
gem 'newrelic_rpm'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'pundit'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.rc1'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# A Ruby static code analyzer and formatter, based on the community Ruby style guide.
gem 'rubocop', '~> 0.79.0', require: false
gem 'rubocop-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'sendgrid-ruby'
# Simple, efficient background processing for Ruby.
gem 'sidekiq'
gem 'webpacker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Fixtures replacement
  gem 'factory_bot_rails'
  # Test suite
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  # Security audit and conding practices - will break the build
  # require: false explanation - https://stackoverflow.com/questions/4800721/what-does-require-false-in-gemfile-mean
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman', require: false
  # https://github.com/rubysec/bundler-audit
  gem 'bundler-audit', require: false
  # Suggested for better coding practices - won't break the build
  # 'Rubocop for fast-ruby'
  # https://github.com/DamirSvrtan/fasterer
  gem 'fasterer'
  # https://github.com/guard/guard-rspec
  gem 'guard-rspec', require: false
  # Look for missing indexes
  # https://github.com/plentz/lol_dba
  gem 'lol_dba'
  # https://github.com/rubocop-hq/rubocop-rspec
  gem 'rubocop-rspec', require: false
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  # Stub environment variables
  gem 'climate_control'
  # Cleans the test database before each test
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  # Additional matchers
  gem 'shoulda-matchers', require: false
  # Calculates the tests coverage
  gem 'simplecov', require: false
  # Freezes time in specs
  gem 'timecop'
end
