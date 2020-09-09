# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

def initialized_server?
  defined?(Rails::Server) || (defined?(::Puma) && File.basename($PROGRAM_NAME).starts_with?('puma')) ||
    (defined?(::Nack::Server) && File.basename($PROGRAM_NAME).starts_with?('nack')) # nack is Pow
end

module FullStackChang
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults '6.0'

    config.active_record.belongs_to_required_by_default = false
    config.assets.paths << Rails.root.join('public')
    config.time_zone = 'Brisbane'
    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    # === GENERATORS ===
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

    # === ACTIVE JOB ===
    config.active_job.queue_adapter = :sidekiq

    # === AFTER INITIALIZE ===
    config.after_initialize do
      if initialized_server? && Rails.env.production?
        # Creating defaults
        Exchange.create_default_exchanges
        TradePair.create_default_trade_pairs

        # Jobs
        AccumulateCryptoJob.perform_now
      end
    end
  end
end
