# frozen_string_literal: true

class ProcessOpenOrderJob < ApplicationJob
  def perform(order_id)
    return if Order.where('updated_at > ?', Time.current - 1.minute).count > 777
    return unless (order = Order.find_by(id: order_id))

    order.update_from_exchange
    return unless order.persisted?

    order.create_counter if order.filled? && %w[accumulate counter_only].include?(order.trade_pair.mode)
    order.cancel if order.stale?(order.trade_pair.mode == 'accumulate' ? 3 : 0)
  end
end
