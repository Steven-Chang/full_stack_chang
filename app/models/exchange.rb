# frozen_string_literal: true

# maker_fee and taker_fee to be the percentage amount
class Exchange < ApplicationRecord
  # === CONSTANTS ===
  DEFAULT_EXCHANGES = {
    coinspot: {
      name: 'CoinSpot',
      url: 'https://www.coinspot.com.au/',
      maker_fee: 0.1,
      taker_fee: 0.1
    },
    binance: {
      name: 'Binance',
      url: 'https://www.binance.com/en',
      maker_fee: 0.1,
      taker_fee: 0.1
    }
  }.freeze

  # === ASSOCIATIONS ===
  has_many :trade_pairs, dependent: :destroy

  # === VALIDATIONS ===
  validates :identifier, :name, presence: true

  # === CLASS METHODS ===
  def self.create_default_exchanges
    DEFAULT_EXCHANGES.each do |identifier, value|
      next if Exchange.find_by(identifier: identifier)

      Exchange.create(identifier: identifier, name: value[:name], url: value[:url], maker_fee: value[:maker_fee], taker_fee: value[:taker_fee])
    end
  end

  # === INSTANCE METHODS ===

  def client
    case identifier
    when 'binance'
      Binance::Client::REST.new(api_key: Rails.application.credentials.binance_steven[:api_key],
                                secret_key: Rails.application.credentials.binance_steven[:secret_key])
    else
      raise StandardError, 'No client for that exchange'
    end
  end
end
