# frozen_string_literal: true

class ProcessOpenOrdersJob < ApplicationJob
  queue_as :low

  def perform
    Credential.where(enabled: true)
              .find_each do |credential|
                credential.orders
                          .where(status: 'open')
                          .joins(:trade_pair)
                          .where(trade_pairs: { enabled: true })
                          .where('orders.created_at < ?', 2.minutes.ago)
                          .find_each do |order|
        ProcessOpenOrderJob.perform_later(order.id)
                end
    end
  end
end
