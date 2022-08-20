# frozen_string_literal: true

class ProcessOpenOrderJob < ApplicationJob
  queue_as :low

  def perform(order_id)
    return unless (order = Order.find_by(id: order_id))

    order.update_from_exchange
    return unless order.persisted?

    trade_pair_mode = order.trade_pair.mode
    order.create_counter if order.filled? && %w[accumulate counter_only].include?(trade_pair_mode)
    order.cancel if order.stale?(trade_pair_mode == 'counter_only' ? 0 : 6)
  end
end
