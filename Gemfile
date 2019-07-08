# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# This will allow our API to expose only those fields that are necessary to Angular frontend.
gem 'active_model_serializers'
# A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts.
gem 'acts-as-taggable-on', '~> 6.0'
gem 'angular_rails_csrf'
# allows us to place our html views in the assets/javascript directory
gem 'angular-rails-templates'
gem 'aws-sdk', '~> 2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.1.1'
# https://github.com/Nerian/bootstrap-datepicker-rails
gem 'bootstrap-datepicker-rails'
# Recommendations from https://www.sitepoint.com/setting-up-an-angular-spa-on-rails-with-devise-and-bootstrap/
gem 'bower-rails'
gem 'devise'
# Build JSON APIs with ease. Read more: httgem 'puma', '~> 3.11's://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'lodash-rails'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
# Monitoring the app
# https://rpm.newrelic.com/accounts/2222353/applications/setup#ruby
gem 'newrelic_rpm'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'pundit'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'sendgrid-ruby'
gem 'sprockets-rails', require: 'sprockets/railtie'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# https://github.com/watir/watir-rails
gem 'watir-rails'
# Gemfile for Rails 3+, Sinatra, and Merb
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Fixtures replacement
  gem 'factory_bot_rails'
  # To auto test jasmine spec files on saving of any files
  gem 'guard-jasmine'
  gem 'jasmine-rails'
  # Test suite
  gem 'rspec-rails', '~> 3.5'
  # https://github.com/travisjeffery/sinon-rails
  gem 'sinon-rails'
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
  # https://github.com/rubocop-hq/rubocop
  # RuboCop is a Ruby static code analyzer and code formatter.
  # Out of the box it will enforce many of the guidelines outlined in the community Ruby Style Guide.
  gem 'rubocop', '~> 0.63.0', require: false
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
  gem 'capybara', '>= 2.15', '< 4.0'
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

group :production do
  gem 'rails_12factor'
end
