# frozen_string_literal: true

class CancelOutOfRangeOrdersJob < ApplicationJob
  queue_as :low

  def perform(_exchange_id, _symbol)
    CancelStaleOrderJob.perform_later(order.id)
  end
end
