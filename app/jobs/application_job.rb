# frozen_string_literal: true

require 'sidekiq/api'

class ApplicationJob < ActiveJob::Base
  queue_as :default

  def self.scheduled?
    Sidekiq::ScheduledSet.new.any? { |job| job.item['wrapped'] == name }
  end
end
