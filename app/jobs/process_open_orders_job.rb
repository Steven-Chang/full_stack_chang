# frozen_string_literal: true

class ProcessOpenOrdersJob < ApplicationJob
  after_perform do |_job|
    ProcessOpenOrdersJob.set(wait_until: Time.zone.now + 1.minute).perform_later unless ProcessOpenOrdersJob.scheduled?
  end

  def perform
    return if Order.where('updated_at > ?', Time.current - 1.minute).count > 777

    Credential.where(enabled: true).find_each do |credential|
      credential.trade_pairs.where(enabled: true).find_each do |trade_pair|
        trade_pair.orders.where(status: 'open').find_each do |order|
          ProcessOpenOrderJob.perform_later(order.id)
        end
      end
    end
  end
end
