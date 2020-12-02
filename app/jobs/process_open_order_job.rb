# frozen_string_literal: true

class ProcessOpenOrderJob < ApplicationJob
  def perform(order_id)
    if Order.where('updated_at > ?', Time.current - 1.minute).count > 777
      ProcessOpenOrderJob.set(wait_until: Time.zone.now + 3.minutes).perform_later(order_id)
    elsif (order = Order.find_by(id: order_id))
      order.update_from_exchange
      return unless order.persisted?

      order.create_counter if order.filled? && %w[accumulate counter_only].include?(order.trade_pair.mode)
      order.cancel if order.stale?
    end
  end
end
