# frozen_string_literal: true

class UpdateOrderFromExchangeJob < ApplicationJob
  queue_as :low

  def perform(order_id)
    return unless (order = Order.find_by(id: order_id))

    order.update_from_exchange
  end
end
