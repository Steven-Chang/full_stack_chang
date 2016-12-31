# frozen_string_literal: true

# maker_fee and taker_fee to be the percentage amount
class Exchange < ApplicationRecord
  # === CONSTANTS ===
  DEFAULT_EXCHANGES = {
    binance: {
      name: 'Binance',
      url: 'https://www.binance.com/en',
      maker_fee: 0.1,
      taker_fee: 0.1
    }
  }.freeze

  # === ASSOCIATIONS ===
  has_many :credentials, dependent: :destroy
  has_many :trade_pairs, through: :credentials

  # === VALIDATIONS ===
  validates :identifier, :maker_fee, :name, :taker_fee, :url, presence: true

  # === CLASS METHODS ===
  def self.create_default_exchanges
    DEFAULT_EXCHANGES.each do |identifier, value|
      next if Exchange.find_by(identifier:)

      Exchange.create(identifier:, name: value[:name], url: value[:url], maker_fee: value[:maker_fee], taker_fee: value[:taker_fee])
    end
  end

  # === INSTANCE METHODS ===
end
