require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FullStackChang
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # In Rails 5.0, returning false in an Active Record or Active Model callback will not have this side effect of halting the callback chain. Instead, callback chains must be explicitly halted by calling throw(:abort).
    ActiveSupport.halt_callback_chains_on_return_false = false


    config.active_record.belongs_to_required_by_default = true

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.assets false
    end
  end
end
