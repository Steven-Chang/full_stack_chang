source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Recommendations from https://www.sitepoint.com/setting-up-an-angular-spa-on-rails-with-devise-and-bootstrap/
gem 'bower-rails'
gem 'devise'
# allows us to place our html views in the assets/javascript directory
gem 'angular-rails-templates'
# Bootstrap also requires the 'sass-rails' gem, which should be included in your gemfile
gem 'bootstrap-sass', '~> 3.3.6'
# This will allow our API to expose only those fields that are necessary to Angular frontend.
gem 'active_model_serializers', '~> 0.10.0'

gem 'lodash-rails'

gem 'angular_rails_csrf'

# Supposedly this wills stop that 
# Sign out issue that we have
gem 'activerecord-session_store'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg'
end