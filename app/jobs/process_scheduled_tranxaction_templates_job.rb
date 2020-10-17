# frozen_string_literal: true

class ProcessScheduledTranxactionTemplatesJob < ApplicationJob
  after_perform do |_job|
    ProcessScheduledTranxactionTemplatesJob.set(wait_until: Time.zone.now + 3.hours).perform_later unless ProcessScheduledTranxactionTemplatesJob.scheduled?
  end

  def perform
    ScheduledTranxactionTemplate.process
  end
end
