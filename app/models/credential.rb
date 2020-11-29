# frozen_string_literal: true

class Credential < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :exchange
  has_many :trade_pairs, dependent: :restrict_with_exception

  # === CLASS METHODS ===
  def self.create_defaults
    Rails.application.credentials.binance.each do |identifier, _v|
      next unless (exchange_binance = Exchange.find_by(identifier: 'binance'))
      next if Credential.find_by(identifier: identifier, exchange: exchange_binance).present?

      Credential.create(identifier: identifier, exchange: exchange_binance)
    end
  end

  def self.trade
    Credential.where(enabled: true).find_each do |credential|
      # This is needed to do the trade pairs that don't have any orders first
      # Can refactor in the future but not crucial
      credential.trade_pairs.where(enabled: true).find_each do |trade_pair|
        AccumulateTradePairJob.perform_later(trade_pair.id) if trade_pair.orders.empty?
      end

      credential.trade_pairs
                .where(enabled: true)
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
