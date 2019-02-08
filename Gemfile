source 'https://rubygems.org'
ruby "2.5.1"

gem 'aws-sdk', '~> 2'

# Monitoring the app
# https://rpm.newrelic.com/accounts/2222353/applications/setup#ruby
gem 'newrelic_rpm'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'

gem 'rspotify'

# https://github.com/laserlemon/figaro
gem "figaro"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

gem 'sendgrid-ruby'

gem 'sprockets-rails', :require => 'sprockets/railtie'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-ui-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Recommendations from https://www.sitepoint.com/setting-up-an-angular-spa-on-rails-with-devise-and-bootstrap/
gem 'bower-rails'
gem 'devise'
# allows us to place our html views in the assets/javascript directory
gem 'angular-rails-templates'

gem 'bootstrap', '~> 4.1.1'

# This will allow our API to expose only those fields that are necessary to Angular frontend.
gem 'active_model_serializers'

gem 'lodash-rails'

gem 'angular_rails_csrf'

# https://github.com/Nerian/bootstrap-datepicker-rails
gem 'bootstrap-datepicker-rails'

# Gemfile for Rails 3+, Sinatra, and Merb
gem 'will_paginate', '~> 3.1.0'

# https://github.com/watir/watir-rails
gem "watir-rails"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Fixtures replacement
  gem 'factory_bot_rails'

  # Test suite
  gem 'rspec-rails', '~> 3.5'

  gem 'sqlite3'
  gem 'jasmine-rails'
  # https://github.com/travisjeffery/sinon-rails
  gem 'sinon-rails'
  # To auto test jasmine spec files on saving of any files
  gem 'guard-jasmine'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Security audit and conding practices - will break the build
  # require: false explanation - https://stackoverflow.com/questions/4800721/what-does-require-false-in-gemfile-mean
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman', require: false
  # https://github.com/rubysec/bundler-audit
  gem 'bundler-audit', require: false
  # https://github.com/rubocop-hq/rubocop
  # RuboCop is a Ruby static code analyzer and code formatter. Out of the box it will enforce many of the guidelines outlined in the community Ruby Style Guide.
  gem 'rubocop', '~> 0.63.0', require: false
  # https://github.com/rubocop-hq/rubocop-rspec
  gem 'rubocop-rspec', require: false

  # Suggested for better coding practices - won't break the build
  # 'Rubocop for fast-ruby'
  # https://github.com/DamirSvrtan/fasterer
  gem 'fasterer'
  # Look for missing indexes
  # https://github.com/plentz/lol_dba
  gem 'lol_dba'

  # https://github.com/guard/guard-rspec
  gem 'guard-rspec', require: false
end

group :test do
  # Additional matchers
  gem 'shoulda-matchers', require: false

  # Calculates the tests coverage
  gem 'simplecov', require: false

  # Freezes time in specs
  gem 'timecop'

  # Cleans the test database before each test
  gem 'database_cleaner'

  # Stub environment variables
  gem 'climate_control'

  # Used for resources specs
  # Use base repo after https://github.com/G5/jsonapi-resources-matchers/pull/15 is merged
  gem 'jsonapi-resources-matchers', git: 'https://github.com/cesar-tonnoir/jsonapi-resources-matchers.git', branch: 'master'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end