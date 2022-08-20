# frozen_string_literal: true

class ProcessScheduledTranxactionTemplatesJob < ApplicationJob
  queue_as :low

  def perform
    ScheduledTranxactionTemplate.process
  end
end
