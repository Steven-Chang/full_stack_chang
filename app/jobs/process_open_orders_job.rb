# frozen_string_literal: true

class ProcessOpenOrdersJob < ApplicationJob
  after_perform do |_job|
    ProcessOpenOrdersJob.set(wait_until: Time.zone.now + 1.minute).perform_later unless ProcessOpenOrdersJob.scheduled?
  end

  def perform
    Credential.where(enabled: true).find_each do |credential|
      credential_orders = credential.orders
      next if credential_orders.where('orders.updated_at > ?', Time.current - 1.minute).count > 333

      credential_orders.where(status: 'open').joins(:trade_pair).where(trade_pairs: { enabled: true }).find_each do |order|
        ProcessOpenOrderJob.perform_later(order.id)
      end
    end
  end
end
