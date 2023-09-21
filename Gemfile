# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'activeadmin', '~> 2.14'
gem 'airbrake'
# This one is needed when deleting
# gem 'aws-sdk-s3', '~> 1'
gem 'aws-sdk-s3', require: false
gem 'bcrypt'
gem 'binance', github: 'steven-chang/binance'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
gem 'chartkick'
gem 'cloudinary'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails', '>= 0.1.0'
gem 'devise'
# Barebones two-factor authentication with Devise
gem 'devise-two-factor', tag: 'v5.0.0'
gem 'groupdate'
# Provides Haml generators for Rails 4 etc
gem 'haml-rails'
gem 'image_processing', '>= 1.2'
# Foreign key migration generator for Rails
gem 'immigrant'
# Build JSON APIs with ease. Read more: httgem 'puma', '~> 3.11's://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# https://github.com/sparklemotion/mechanize
gem 'mechanize'
gem 'monetize'
gem 'money'
# Monitoring the app
gem 'pg'
gem 'puma'
gem 'pundit'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.7.2'
# Use SCSS for stylesheets
gem 'sassc-rails'
gem 'sprockets-rails'

group :development do
  gem 'active_record_doctor'
  gem 'bullet'
  # Guard::RSpec automatically run your specs
  gem 'guard-rspec'
  gem 'listen', '~> 3.3'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'haml_lint', require: false
  # Behaviour Driven Development for Ruby
  gem 'rspec-rails'
  # A Ruby static code analyzer and formatter, based on the community Ruby style guide.
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'scss_lint', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'selenium-webdriver'
  # Collection of testing matchers extracted from Shoulda
  gem 'shoulda-matchers', require: false
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
