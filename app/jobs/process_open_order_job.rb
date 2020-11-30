# frozen_string_literal: true

class ProcessOpenOrderJob < ApplicationJob
  def perform(order_id)
    if Order.where('updated_at > ?', Time.current - 1.minute).count > 777
      ProcessOpenOrderJob.set(wait_until: Time.zone.now + 1.minute).perform_later(order_id)
    elsif (order = Order.where(id: order_id).first)
      order.update_from_exchange
      if (order = Order.where(id: order_id).first)
        order.create_counter if order.filled? && (order.trade_pair.mode == 'accumulate' || order.trade_pair.mode == 'counter_only')
        order.cancel if order.stale?
      end
    end
  end
end
