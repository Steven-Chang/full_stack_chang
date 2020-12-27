# frozen_string_literal: true

class Credential < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :exchange
  has_many :trade_pairs, dependent: :restrict_with_exception
  has_many :orders, through: :trade_pairs

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
      trade_pairs_enabled = credential.trade_pairs.where(enabled: true)
      # This is needed to do the trade pairs that don't have any orders first
      # Can refactor in the future but not crucial
      trade_pairs_enabled.find_each do |trade_pair|
        AccumulateTradePairJob.perform_later(trade_pair.id) if trade_pair.orders.where(status: 'open').empty?
      end

      trade_pairs_enabled.where('orders.status = ?', 'open')
                         .left_joins(:orders)
                         .group(:id)
                         .order('COUNT(orders.id) ASC')
                         .pluck(:id)
                         .each do |trade_pair_id|
        AccumulateTradePairJob.perform_later(trade_pair_id)
      end
    end
  end

  # === INSTANCE METHODS ===
  def client
    case exchange.identifier
    when 'binance'
      rails_credentials = Rails.application.credentials
      binance_credentials = Rails.env.production? ? rails_credentials.binance[identifier.to_sym] : rails_credentials.development[:binance][:test]
      Binance::Client::REST.new(api_key: binance_credentials[:api_key], secret_key: binance_credentials[:secret_key])
    else
      raise StandardError, 'No client for that exchange'
    end
  end
end
