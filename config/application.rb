# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

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
    config.generators do |generator|
      # Assets == js & Stylesheets
      generator.assets false
      generator.helper false
      generator.jbuilder false
      generator.serializer false
      generator.stylesheets false
    end

    # === ACTIVE JOB ===
    config.active_job.queue_adapter = :sidekiq
  end

  # Set table name prefix here so that it applies to active admin comments table
  ActiveRecord::Base.table_name_prefix = 'fsc_'
end
