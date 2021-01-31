# frozen_string_literal: true

# MINIMUM_TOTAL is for the BASE ASSET(the second of the trading pair)
# AMOUNT STEP is for the QUOTE ASSET(the first of the trading pair)
# AMOUNT STEP COULD ALSO BE CALLED QUANTITY STEP

# maker_fee and taker_fee to be the percentage amount
class TradePair < ApplicationRecord
  # === CONSTANTS ===
  DEFAULT_TRADE_PAIRS = YAML.load_file(Rails.root.join('db/defaults/trade_pairs.yml'))
  MAX_TRADE_FREQUENCY_IN_SECONDS = 7

  # === ASSOCIATIONS ===
  belongs_to :credential, optional: true
  has_one :exchange, through: :credential
  has_many :orders, dependent: :destroy

  # === ENUMERABLES ===
  enum mode: { accumulate: 0, buy: 1, sell: 2, counter_only: 3 }

  # === VALIDATIONS ===
  validates :percentage_from_market_price_buy_minimum,
            :percentage_from_market_price_buy_maximum,
            numericality: {
              allow_nil: true,
              greater_than_or_equal_to: 0.01,
              less_than_or_equal_to: 100
            }
  validates :symbol, presence: true
  validates :symbol, uniqueness: { case_sensitive: false, scope: :credential_id }
  validates :amount_step,
            :minimum_total,
            :price_precision,
            presence: true,
            if: proc { |trade_pair| trade_pair.enabled }
  validates :accumulate_time_limit_in_seconds, numericality: { greater_than_or_equal_to: MAX_TRADE_FREQUENCY_IN_SECONDS, allow_nil: true }

  # === CALLBACKS ===
  before_save do |trade_pair|
    if trade_pair.exchange&.open_orders_limit_per_trade_pair&.present?
      if trade_pair.open_orders_limit.present? && trade_pair.open_orders_limit > trade_pair.exchange.open_orders_limit_per_trade_pair
        trade_pair.open_orders_limit = trade_pair.exchange.open_orders_limit_per_trade_pair
      elsif trade_pair.open_orders_limit.blank?
        trade_pair.open_orders_limit = trade_pair.exchange.open_orders_limit_per_trade_pair
      end
    end
    trade_pair.symbol.downcase!
  end

  # === DELEGATES ===
  delegate :client,
           to: :credential

  # === SCOPES ===
  scope :enabled, lambda { where(enabled: true) }
  scope :disabled, lambda { where.not(enabled: true) }

  # === CLASS METHODS ===
  def self.create_default_trade_pairs
    DEFAULT_TRADE_PAIRS.each do |exchange_identifier, values|
      next unless exchange_identifier.to_s == 'binance'
      next unless (exch = Exchange.find_by(identifier: exchange_identifier))

      exch.credentials.each do |credential|
        values.each do |trade_pair_symbol, trade_pair_values|
          next if credential.trade_pairs.find_by(symbol: trade_pair_symbol)

          credential.trade_pairs.create(symbol: trade_pair_symbol,
                                        url: trade_pair_values['url'],
                                        minimum_total: trade_pair_values['minimum_total'],
                                        amount_step: trade_pair_values['amount_step'],
                                        price_precision: trade_pair_values['price_precision'])
        end
      end
    end
  end

  # === INSTANCE METHODS ===
  # Although this is called accumulate, handles all modes
  # Eventually want to change this to trade
  # Does not handle 'sell right now'
  def accumulate
    return unless enabled
    return unless credential.enabled
    return unless exchange.identifier == 'binance'
    return if mode == 'sell'
    return if mode == 'counter_only'
    return if accumulate_order_limit_reached?

    if limit_price.present?
      percentage_from_market_price = nil
      next_price = limit_price
    else
      percentage_from_market_price = rand(percentage_from_market_price_minimum('buy')..percentage_from_market_price_maximum('buy')).round(2)
      next_price = get_open_buy_orders(5)[0][:rate].to_d * ((100 - percentage_from_market_price) / 100)
    end
    base_total = minimum_total
    quantity = calculate_quantity(base_total, next_price)
    create_order('buy', next_price, quantity, nil, percentage_from_market_price)
  end

  # Watch out for the difference in base_total and quantity
  # base_total in Binance is the bottom input total
  # and quantity is the middle one which we submit which is the middle one
  # That's why there's all these calculations
  def create_order(buy_or_sell, price, quantity, order_id = nil, percentage_from_market_price = nil)
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
      if (binance_order_id = result['orderId'])
        orders.create(status: result['status'].downcase == 'filled' ? 'filled' : 'open',
                      buy_or_sell: buy_or_sell,
                      price: result['price'],
                      quantity: result['origQty'].to_d,
                      reference: binance_order_id,
                      order_id: order_id,
                      percentage_from_market_price: percentage_from_market_price)
      else
        puts result.inspect
      end
    end
  end

  def get_open_buy_orders(number_of_orders = 5)
    orders = []

    case exchange.identifier
    when 'coinspot'
      mechanize_instance = Mechanize.new
      page = mechanize_instance.get(url)
      selector = '.openbuyrows'
      number_of_orders.times do |row_number|
        order = parse_and_map_order_retrieved_order(page.search(selector)[row_number])
        orders.push(order)
      end
    when 'binance'
      number_of_orders = number_of_orders < 5 ? 5 : number_of_orders
      retrieved_object = client.depth(symbol: symbol.upcase, limit: number_of_orders)
      raise StandardError, retrieved_object['msg'] if retrieved_object['code'].present?

      retrieved_orders = retrieved_object['bids']
      retrieved_orders.each do |retrieved_order|
        order = parse_and_map_order_retrieved_order(retrieved_order)
        orders.push(order)
      end
    else
      raise StandardError, "Exchange isn's set up to get open orders"
    end

    orders
  end

  def get_open_sell_orders(number_of_orders = 5)
    orders = []

    case exchange.identifier
    when 'coinspot'
      mechanize_instance = Mechanize.new
      page = mechanize_instance.get(url)
      selector = '.opensellrows'
      number_of_orders.times do |row_number|
        order = parse_and_map_order_retrieved_order(page.search(selector)[row_number])
        orders.push(order)
      end
    when 'binance'
      number_of_orders = number_of_orders < 5 ? 5 : number_of_orders
      retrieved_object = client.depth(symbol: symbol.upcase, limit: number_of_orders)
      raise StandardError, retrieved_object['msg'] if retrieved_object['code'].present?

      retrieved_orders = retrieved_object['asks']
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

  def accumulate_order_limit_reached?
    open_buy_orders = orders.where(status: 'open', buy_or_sell: 'buy')
    open_sell_orders = orders.where(status: 'open', buy_or_sell: 'sell')

    return true if open_orders_limit.present? && open_buy_orders.count + open_sell_orders.count >= open_orders_limit

    accumulate_limit_time = Time.current - (accumulate_time_limit_in_seconds&.seconds || 12.minutes)
    open_buy_orders.where('created_at > ?', accumulate_limit_time).present?
  end

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
      retrieved_order_childen = retrieved_order.children
      { amount: retrieved_order_childen[1].text.split(' ').first.to_d,
        rate_cents: Monetize.parse(retrieved_order_childen[3].text).fractional,
        total_cents: retrieved_order_childen[5].text }
    when 'binance'
      { amount: retrieved_order.second.to_d,
        rate: retrieved_order.first }
    else
      raise StandardError, "Exchange isn't set up to parse and map retrieved orders"
    end
  end

  def percentage_from_market_price_minimum(buy_or_sell)
    return if buy_or_sell != 'buy'

    percentage_from_market_price_buy_minimum || TradePair.find_by(symbol: 'master')&.percentage_from_market_price_buy_minimum || 1.01
  end

  def percentage_from_market_price_maximum(buy_or_sell)
    return if buy_or_sell != 'buy'

    percentage_from_market_price_buy_maximum || TradePair.find_by(symbol: 'master')&.percentage_from_market_price_buy_maximum || 3
  end
end
