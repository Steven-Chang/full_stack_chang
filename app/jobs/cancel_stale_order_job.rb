# frozen_string_literal: true

class CancelStaleOrderJob < ApplicationJob
  def perform(order_id)
    return unless (order = Order.find_by(id: order_id))

    order.cancel
  end
end
