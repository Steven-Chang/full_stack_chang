# frozen_string_literal: true

# Binance how to get assets and commission fees
# client.account_info
#  => {"makerCommission"=>10, "takerCommission"=>10, "buyerCommission"=>0, "sellerCommission"=>0, "canTrade"=>true, "canWithdraw"=>true, "canDeposit"=>true, "updateTime"=>1599083626830, "accountType"=>"SPOT", "balances"=>[{"asset"=>"BTC", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"LTC", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"ETH", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"NEO", "free"=>"0.00000000", "locked"=>"0.00000000"}, {"asset"=>"BNB", "free"=>"0.85509867", "
  
# MINIMUM_TOTAL is for the BASE ASSET(the second of the trading pair)
# MINIMUM STEP is for the QUOTE ASSET(the first of the trading pair)

# maker_fee and taker_fee to be the percentage amount
class TradePair < ApplicationRecord
  # === CONSTANTS ===
  DEFAULT_TRADE_PAIRS = {
    coinspot: {
      btcaud: {
        url: 'https://www.coinspot.com.au/trade/BTC'
      }
    },
    binance: {
      btcaud: {
        minimum_total: 20,
        amount_step: 0.000002
      },
      bnbeth: {
        amount_step: 0.02,
        minimum_total: 0.02,
        price_precision: 6
      }
    }
  }.freeze

  # === ASSOCIATIONS ===
  belongs_to :exchange
  has_many :orders, dependent: :destroy

  # === VALIDATIONS ===
  validates :symbol, presence: true
  validates :symbol, uniqueness: { case_sensitive: false, scope: :exchange_id }
  validates :amount_step,
            :minimum_total,
            :price_precision,
            presence: true,
            if: Proc.new { |trade_pair| trade_pair.active_for_accumulation }

  # === CALLBACKS ===
  before_save { symbol.downcase! }

  # === DELEGATES ===
  delegate :client, to: :exchange

  # === CLASS METHODS ===
  def self.accumulate
    where(active_for_accumulation: true).find_each do |trade_pair|
      trade_pair.accumulate
    end
  end

  def self.create_default_trade_pairs
    DEFAULT_TRADE_PAIRS.each do |exchange_identifier, values|
      next unless (exch = Exchange.find_by(identifier: exchange_identifier))

      values.each do |trade_pair_symbol, trade_pair_values|
        next if exch.trade_pairs.find_by(symbol: trade_pair_symbol)

        exch.trade_pairs.create(symbol: trade_pair_symbol,
                                url: trade_pair_values[:url],
                                minimum_total: trade_pair_values[:minimum_total],
                                amount_step: trade_pair_values[:amount_step])
      end
    end
  end

  # === INSTANCE METHODS ===
  # This is to trade between the two pairs on the basis that fluctuations will give opportunities to increase the size of either
  # In the end if one is worth way more than the other, it's not a big deal
  # Currently the idea is to stack up BNB & CRO with all the different trade pairs that you want more of anyways
  # The great thing is you can work with minimal balance and go from there
  # DO THIS ONLY WITH CRO AND BNB PAIRS FOR NOW AS WE WANT TO STACK THOSE TO GET CHEAPER FEES
  # quantity * price = quantity_received
  # so I want to sell less and receive more
  def accumulate
    return unless active_for_accumulation

    check_and_update_open_orders

    return if orders.where(status: 'open').present?

    last_filled_order = orders.where(status: 'filled').order(:updated_at).last

    if last_filled_order.nil? || last_filled_order.status == 'sell'
      next_buy_or_sell = 'buy'
      next_price = get_open_orders(next_buy_or_sell).third[:rate].to_d
      next_quantity = trade_amount_desired(next_price, nil, amount_step.to_s.split('.').last.size)
    else
      next_buy_or_sell = 'sell'
      next_quantity = last_filled_order.quantity - amount_step
      next_price = (last_filled_order.quantity_received * 1.01) / next_quantity

      raise 'check calculations' if next_price <= last_filled_order.price
      raise 'check calculations' if next_quantity >= last_filled_order.quantity
    end

    create_order(next_buy_or_sell, next_price, next_quantity)
  end

  # The quantity here is the amount
  # In BNBETH - that is the BNB
  def create_order(buy_or_sell, price, quantity)
    price = price.truncate(price_precision)

    case exchange.identifier
    when 'binance'
      result = client.create_order!(symbol: symbol.upcase, side: buy_or_sell, type: 'limit', time_in_force: 'GTC', quantity: quantity.to_s, price: price.to_s)
      if result['orderId']
        orders.create(status: result['status'].downcase == 'filled' ? 'filled' : 'open', buy_or_sell: buy_or_sell, price: result['price'], quantity: quantity, reference: result['orderId'])
      else
        puts result.inspect
      end
    end
  end

  def get_open_orders(buy_or_sell, number_of_orders = 5)
    orders = []

    case exchange.identifier
    when 'coinspot'
      m = Mechanize.new
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

  def import_orders
    case exchange.identifier
    when 'binance'
      # https://binance-docs.github.io/apidocs/spot/en/#account-trade-list-user_data
      client.all_orders(symbol: symbol.upcase).each do |retrieved_order|
        reference = retrieved_order['orderId'].to_s
        next if orders.find_by(reference: reference).present?

        status = retrieved_order['status'].downcase
        if status == 'canceled'
          quantity = retrieved_order['executedQty'].to_d
          if quantity == 0
            next
          else
            status = 'filled'
          end
        else
          quantity = retrieved_order['origQty'].to_d
        end

        orders.create!(reference: reference,
                      status: status,
                      buy_or_sell: retrieved_order['side'],
                      price: retrieved_order['price'].to_d,
                      quantity: quantity,
                      quantity_received: retrieved_order['cummulativeQuoteQty'].to_d)
      end
    end
  end

  # amount in cents if currency
  def order_with_enough_liquidity(buy_or_sell, amount = nil)
    get_open_orders(buy_or_sell).each do |open_order|
      desired_trade_amount = buy_or_sell == 'sell' ? trade_amount_desired(open_order[:rate_cents]) : amount
      return open_order if trade_amount_available?(desired_trade_amount, open_order[:amount])
    end
    nil
  end

  # This needs review as calculating money
  def trade_fee_total(quantity, rate, maker_or_taker = 'maker')
    quantity * rate * trade_fee_general(maker_or_taker) / 100
  end

  def trade_fee_general(maker_or_taker)
    case maker_or_taker
    when 'maker'
      maker_fee.presence || exchange.maker_fee
    when 'taker'
      taker_fee.presence || exchange.taker_fee
    else
      'enter raise error code here when you get time and is needed'
    end
  end

  # If in dollars this will be calculated in cents
  def trade_total(quantity, rate, maker_or_taker = 'maker')
    tft = trade_fee_total(quantity, rate, maker_or_taker)
    tft *= -1 if maker_or_taker == 'taker'
    rate * quantity + tft
  end

  private

  def check_and_update_open_orders
    orders.where(status: 'open').each do |order|
      order.update_from_exchange
    end
  end

  def open_orders?
    client.open_orders(symbol.upcase).present?
  end

  # This needs review for currency
  def parse_and_map_order_retrieved_order(retrieved_order)
    case exchange.identifier
    when 'coinspot'
      { amount: retrieved_order.children[1].text.split(' ').first.to_d,
        rate_cents: Monetize.parse(retrieved_order.children[3].text).fractional,
        total_cents: retrieved_order.children[5].text }
    when 'binance'
      { amount: retrieved_order.second.to_d,
        rate: retrieved_order.first }
    else
      raise StandardError.new "Exchange isn't set up to parse and map retrieved orders"
    end
  end

  # if amount or rate is currency, it must be in cents
  def trade_amount_available?(trade_amount_desired, amount_available_in_order)
    amount_available_in_order >= trade_amount_desired
  end

  # if amount is currency, it must be in cents
  # The amount in BNBETH is the amount of BNB
  def trade_amount_desired(rate, amount = nil, truncate = 4)
    amount ||= minimum_total * 2

    (amount / rate.to_d).truncate(truncate)
  end
end
