# frozen_string_literal: true

class AccumulateCryptoJob < ApplicationJob
  after_perform do |_job|
    AccumulateCryptoJob.set(wait_until: Time.zone.now + 33.seconds).perform_later unless AccumulateCryptoJob.scheduled?
  end

  def perform
    Credential.where(enabled: true).find_each do |credential|
      # This is needed to do the trade pairs that don't have any orders first
      # Can refactor in the future but not crucial
      credential.trade_pairs.where(enabled: true).find_each do |trade_pair|
        AccumulateTradePairJob.perform_later(trade_pair.id) if trade_pair.orders.empty?
      end

      credential.where(enabled: true)
                .where('orders.status = ?', 'open')
                .left_joins(:orders)
                .group(:id)
                .order('COUNT(orders.id) ASC')
                .pluck(:id)
                .each do |trade_pair_id|
        AccumulateTradePairJob.perform_later(trade_pair_id)
      end
    end
  end
end
