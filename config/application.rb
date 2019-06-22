# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FullStackChang
  class Application < Rails::Application
    # Ensuring that ActiveStorage routes are loaded before Comfy's globbing
    # route. Without this file serving routes are inaccessible.
    config.railties_order = [ActiveStorage::Engine, :main_app, :all]
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.active_record.belongs_to_required_by_default = false
    config.assets.paths << Rails.root.join('public')

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end
  end
end
