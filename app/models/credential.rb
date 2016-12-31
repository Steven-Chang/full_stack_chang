# frozen_string_literal: true

class Credential < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :exchange
  has_many :trade_pairs, dependent: :restrict_with_exception
  has_many :orders, through: :trade_pairs

  # === SCOPES ===
  scope :enabled, lambda { where(enabled: true) }

  # === CLASS METHODS ===
  def self.create_defaults
    Rails.application.credentials.binance.each do |identifier, _v|
      next unless (exchange_binance = Exchange.find_by(identifier: 'binance'))
      next if Credential.find_by(identifier: identifier, exchange: exchange_binance).present?

      Credential.create(identifier: identifier, exchange: exchange_binance)
    end
  end

  def self.trade
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
