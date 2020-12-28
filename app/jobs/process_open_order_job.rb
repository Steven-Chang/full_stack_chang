# frozen_string_literal: true

class ProcessOpenOrderJob < ApplicationJob
  def perform(order_id)
    return unless (order = Order.find_by(id: order_id))

    one_minute_ago = 1.minute.ago
    return if order.updated_at > one_minute_ago
    return if order.credential.orders.where('orders.updated_at > ?', one_minute_ago).count > 333

    order.update_from_exchange
    return unless order.persisted?

    trade_pair_mode = order.trade_pair.mode
    order.create_counter if order.filled? && %w[accumulate counter_only].include?(trade_pair_mode)
    if order.stale?(trade_pair_mode == 'counter_only' ? 0 : 6)
      order.cancel
    else
      order.save(updated_at: Time.current)
    end
  end
end
