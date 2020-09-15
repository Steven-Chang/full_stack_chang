# frozen_string_literal: true

# MINIMUM_TOTAL is for the BASE ASSET(the second of the trading pair)
# AMOUNT STEP is for the QUOTE ASSET(the first of the trading pair)
# AMOUNT STEP COULD ALSO BE CALLED QUANTITY STEP

# maker_fee and taker_fee to be the percentage amount
class TradePair < ApplicationRecord
  # === CONSTANTS ===
  DEFAULT_TRADE_PAIRS = YAML.load_file(Rails.root.join('db/defaults/trade_pairs.yml'))

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
            if: proc { |trade_pair| trade_pair.active_for_accumulation }

  # === CALLBACKS ===
  before_save { symbol.downcase! }

  # === DELEGATES ===
  delegate :client, to: :exchange

  # === CLASS METHODS ===
  def self.accumulate
    where(active_for_accumulation: true).find_each do |trade_pair|
      AccumulateTradePairJob.perform_later(trade_pair.id)
    end
  end

  def self.create_default_trade_pairs
    DEFAULT_TRADE_PAIRS.each do |exchange_identifier, values|
      next unless (exch = Exchange.find_by(identifier: exchange_identifier))

      values.each do |trade_pair_symbol, trade_pair_values|
        next if exch.trade_pairs.find_by(symbol: trade_pair_symbol)

        exch.trade_pairs.create(symbol: trade_pair_symbol,
                                url: trade_pair_values['url'],
                                minimum_total: trade_pair_values['minimum_total'],
                                amount_step: trade_pair_values['amount_step'],
                                price_precision: trade_pair_values['price_precision'])
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

    Order.cancel_stale_orders

    orders.where(status: 'open').find_each do |order|
      order.update_from_exchange
      order.reload
      order.create_counter if order.filled?
    end
    open_buy_orders = orders.where(status: 'open', buy_or_sell: 'buy')
    open_sell_orders = orders.where(status: 'open', buy_or_sell: 'sell')

    limit = 77
    starting_limit = 3
    if open_buy_orders.count >= starting_limit || open_sell_orders.count >= starting_limit
      return if open_buy_orders.count >= limit
      return if open_sell_orders.count >= limit
      # return if open_buy_orders.where('created_at > ?', Time.current - 20.minutes).present?
      # Hourly, we want up to 3 open sell orders
      # But can have an infinite number of buy orders to reach that sell limit... The issue is that that means we could use up all those buy orders up in one hit... which is no good so how about we make it 9...
      return if open_buy_orders.where('created_at > ?', Time.current - 1.hour).count >= 9
      return if open_sell_orders.where('created_at > ?', Time.current - 1.hour).count >= 3
    end

    next_price = get_open_orders('buy', 10)[rand(10)][:rate].to_d
    base_total = minimum_total * 2
    quantity = calculate_quantity(base_total, next_price)

    create_order('buy', next_price, quantity)
  end

  # Watch out for the difference in base_total and quantity
  # base_total in Binance is the bottom input total
  # and quantity is the middle one which we submit which is the middle one
  # That's why there's all these calculations
  def create_order(buy_or_sell, price, quantity)
    price = price.truncate(price_precision)
    quantity = quantity_formatted_for_order(quantity)

    case exchange.identifier
    when 'binance'
      result = client.create_order!(symbol: symbol.upcase,
                                    side: buy_or_sell,
                                    type: 'limit',
                                    time_in_force: 'GTC',
                                    quantity: quantity,
                                    price: price.to_s)
      if result['orderId']
        orders.create(status: result['status'].downcase == 'filled' ? 'filled' : 'open',
                      buy_or_sell: buy_or_sell,
                      price: result['price'],
                      quantity: result['origQty'].to_d,
                      reference: result['orderId'])
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
      raise StandardError, "Exchange isn's set up to get open orders"
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
          next if quantity.zero?

          status = 'filled'
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

  def calculate_quantity(base_total, price)
    truncation_factor = amount_step >= 1 ? 0 : amount_step.to_s.split('.').last.size
    (base_total / price).truncate(truncation_factor)
  end

  def quantity_formatted_for_order(quantity)
    quantity = quantity.to_i if amount_step >= 1
    case exchange.identifier
    when 'binance'
      quantity.to_s
    end
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
      raise StandardError, "Exchange isn't set up to parse and map retrieved orders"
    end
  end
end
