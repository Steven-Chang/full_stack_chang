# frozen_string_literal: true

# A note about cancelling orders
# Gotta factor in partially filled orders
class Order < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :parent_order, class_name: 'Order', optional: true, foreign_key: 'order_id', inverse_of: :child_order
  belongs_to :trade_pair
  has_one :credential, through: :trade_pair
  has_one :exchange, through: :trade_pair
  has_one :child_order, class_name: 'Order', dependent: :nullify, foreign_key: 'order_id', inverse_of: :parent_order

  # === VALIDATIONS ===
  validates :status,
            :buy_or_sell,
            :price,
            :quantity,
            presence: true
  validates :buy_or_sell, inclusion: { in: %w[buy sell] }
  validates :status, inclusion: { in: %w[open filled] }

  # === CALLBACKS ===
  before_validation :format_status
  before_validation :format_buy_or_sell

  # === DELEGATES ===
  delegate :symbol,
           :client, to: :trade_pair

  # === INSTANCE METHODS ===
  def cancel
    case exchange.identifier
    when 'binance'
      result = client.cancel_order!(symbol: symbol.upcase, order_id: reference)
      return if result['code'].present?

      destroy!
    end
  end

  def create_counter
    return if buy_or_sell == 'sell'
    return if child_order.present?

    next_buy_or_sell = 'sell'
    next_quantity = quantity - trade_pair.amount_step
    next_price = (quantity_received * (1.0 + (taker_fee_for_calculation * 10))) / next_quantity

    raise StandardError, 'Next price should be higher than current price' if next_price <= price
    raise StandardError, 'Next quantity should be less than current quantity' if next_quantity >= quantity

    trade_pair.create_order(next_buy_or_sell, next_price, next_quantity, id)
  end

  def filled?
    status == 'filled'
  end

  def query
    case exchange.identifier
    when 'binance'
      client.query_order(symbol: symbol.upcase, order_id: reference)
    end
  end

  # Currently we only want to remove old buy orders
  # Move this to private if possible after writing tests
  def stale?(number_of_hours = 3)
    return if quantity_received&.positive?

    buy_or_sell == 'buy' && open? && (created_at < Time.current - number_of_hours.hours)
  end

  def taker_fee_for_calculation
    tf = trade_pair.taker_fee || exchange.taker_fee
    tf / 100
  end

  # Update this later to be able to handle cancelled orders
  def update_from_exchange
    case exchange.identifier
    when 'binance'
      result = query
      return if result['symbol'].blank?

      cummulative_quote_qty = result['cummulativeQuoteQty'].to_d
      result_status = result['status']
      if result_status == 'CANCELED'
        if cummulative_quote_qty.zero?
          destroy!
        else
          update!(status: 'filled', quantity_received: cummulative_quote_qty)
        end
      else
        update!(status: result_status.downcase, quantity_received: cummulative_quote_qty)
      end
    end
  end

  private

  def format_buy_or_sell
    return if buy_or_sell.blank?

    self.buy_or_sell = buy_or_sell.downcase
  end

  def format_status
    return if status.blank?

    self.status = status.downcase
    self.status = 'open' if %w[new partially_filled].include?(status)
  end

  def open?
    status == 'open'
  end
end
