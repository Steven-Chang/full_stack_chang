# frozen_string_literal: true

# Binance how to get assets and commission fees
# client.account_info
#  => {"makerCommission"=>10, "takerCommission"=>10, "buyerCommission"=>0, "sellerCommission"=>0, "canTrade"=>true, "canWithdraw"=>true, "canDeposit"=>true, "updateTime"=>1599083626830, "accountType"=>"SPOT", "balances"=>[{"asset"=>"BTC", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"LTC", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"ETH", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"NEO", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"BNB", "free"=>"0.85509867", "

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

  def self.arbitrage_opportunity_available
    all.find_each do |exchange|
      sell_order = exchange.order_with_enough_liquidity(2000, 'sell')
      if sell_order
        desired_trade_amount = trade_amount_desired(2000, sell_order[:rate_cents])
        buy_trade_total_including_fee_in_cents = exchange.trade_pairs.find_by(symbol: 'btcaud').trade_total(desired_trade_amount, sell_order[:rate_cents])

        where.not(identifier: exchange.identifier).find_each do |exchange_to_sell_at|
          buy_order = exchange_to_sell_at.order_with_enough_liquidity(desired_trade_amount, 'buy')
          if buy_order
            sell_trade_total_including_fee_in_cents = exchange_to_sell_at.trade_pairs.find_by(symbol: 'btcaud').trade_total(desired_trade_amount, buy_order[:rate_cents], 'taker')
            net_result = sell_trade_total_including_fee_in_cents - buy_trade_total_including_fee_in_cents
            if net_result > 0
              return "Buy from #{exchange.name} for #{sell_order[:rate_cents]} and sell at #{exchange_to_sell_at.name} for #{buy_order[:rate_cents]} for a nest result of #{net_result} cents"
            else
              puts "Buying from #{exchange.name} at #{sell_order[:rate_cents]} and selling at #{exchange_to_sell_at.name} for #{buy_order[:rate_cents]} will lose you #{net_result} cents"
            end
          end
        end
      end
    end

    false
  end

  def self.create_default_exchanges
    DEFAULT_EXCHANGES.each do |identifier, value|
      next if Exchange.find_by(identifier: identifier)

      Exchange.create(identifier: identifier, name: value[:name], url: value[:url], maker_fee: value[:maker_fee], taker_fee: value[:taker_fee])
    end
  end

  def get_open_orders(symbol, buy_or_sell, number_of_orders = 5)
    orders = []

    case identifier
    when 'coinspot'
      m = Mechanize.new
      url = trade_pairs.find_by(symbol: symbol).url
      page = m.get(url)
      selector = buy_or_sell == 'buy' ? '.openbuyrows' : '.opensellrows'
      number_of_orders.times do |n|
        order = parse_and_map_order_retrieved_order(page.search(selector)[n])
        orders.push(order)
      end
    when 'binance'
      number_of_orders = number_of_orders < 5 ? 5 : number_of_orders
      retrieved_object = client.depth(symbol: symbol.upcase, limit: number_of_orders)
      retrieved_orders = buy_or_sell == 'buy' ? retrieved_object['bids'] : retrieved_object['asks']
      retrieved_orders.each do |retrieved_order|
        order = parse_and_map_order_retrieved_order(retrieved_order)
        orders.push(order)
      end
    else
      raise StandardError.new "Exchange isn's set up to get open orders"
    end

    orders
  end

  # amount in cents if currency
  def order_with_enough_liquidity(amount, buy_or_sell)
    get_open_orders('btcaud', buy_or_sell).each do |open_order|
      desired_trade_amount = buy_or_sell == 'sell' ? Exchange.trade_amount_desired(amount, open_order[:rate_cents]) : amount
      return open_order if Exchange.trade_amount_available?(desired_trade_amount, open_order[:amount])
    end
    nil
  end

  private

  # if amount or rate is currency, it must be in cents
  def self.trade_amount_available?(trade_amount_desired, amount_available_in_order)
    amount_available_in_order >= trade_amount_desired
  end

  # if amount is currency, it must be in cents
  def self.trade_amount_desired(amount, rate, truncate = 4)
    (amount / rate.to_d).truncate(truncate)
  end

  def client
    case identifier
    when 'binance'
      Binance::Client::REST.new(api_key: Rails.application.credentials.binance_emily[:api_key], secret_key: Rails.application.credentials.binance_emily[:secret_key])
    else
      raise StandardError.new 'No client for that exchange'
    end
  end

  def parse_and_map_order_retrieved_order(retrieved_order)
    case identifier
    when 'coinspot'
      { amount: retrieved_order.children[1].text.split(' ').first.to_d,
        rate_cents: Monetize.parse(retrieved_order.children[3].text).fractional,
        total_cents: retrieved_order.children[5].text }
    when 'binance'
      { amount: retrieved_order.second.to_d,
        rate_cents: Monetize.parse(retrieved_order.first).fractional }
    else
      raise StandardError.new "Exchange isn't set up to parse and map retrieved orders"
    end
  end
end
