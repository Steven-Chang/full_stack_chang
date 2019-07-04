# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FullStackChang
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.active_record.belongs_to_required_by_default = false
    config.assets.paths << Rails.root.join('public')

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    # Don't create assets during scaffold creation
    # Just create as needed otherwise you'll end up with a bunch of unused files
    config.generators do |g|
      # Assets == js & Stylesheets
      g.assets false
      g.helper false
      g.jbuilder false
      g.serializer false
      g.stylesheets false
    end
  end
end
