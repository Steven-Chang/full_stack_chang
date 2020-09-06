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
  # NEEDS A MAJOR REVIEW
  # def self.arbitrage_opportunity_available(symbol = 'btcaud')
  #   all.find_each do |exchange|
  #     sell_order = exchange.trade_pairs.find_by(symbol: symbol).order_with_enough_liquidity('sell')
  #     if sell_order
  #       desired_trade_amount = trade_amount_desired(2000, sell_order[:rate_cents])
  #       buy_trade_total_including_fee_in_cents = exchange.trade_pairs.find_by(symbol: symbol).trade_total(desired_trade_amount, sell_order[:rate_cents])

  #       where.not(identifier: exchange.identifier).find_each do |exchange_to_sell_at|
  #         buy_order = exchange_to_sell_at.trade_pairs.find_by(symbol: symbol).order_with_enough_liquidity(desired_trade_amount, 'buy')
  #         if buy_order
  #           sell_trade_total_including_fee_in_cents = exchange_to_sell_at.trade_pairs.find_by(symbol: symbol).trade_total(desired_trade_amount, buy_order[:rate_cents], 'taker')
  #           net_result = sell_trade_total_including_fee_in_cents - buy_trade_total_including_fee_in_cents
  #           if net_result > 0
  #             return "Buy from #{exchange.name} for #{sell_order[:rate_cents]} and sell at #{exchange_to_sell_at.name} for #{buy_order[:rate_cents]} for a nest result of #{net_result} cents"
  #           else
  #             puts "Buying from #{exchange.name} at #{sell_order[:rate_cents]} and selling at #{exchange_to_sell_at.name} for #{buy_order[:rate_cents]} will lose you #{net_result} cents"
  #           end
  #         end
  #       end
  #     end
  #   end

  #   false
  # end

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
      Binance::Client::REST.new(api_key: Rails.application.credentials.binance_emily[:api_key], secret_key: Rails.application.credentials.binance_emily[:secret_key])
    else
      raise StandardError.new 'No client for that exchange'
    end
  end
end
