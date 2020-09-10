# frozen_string_literal: true

# A note about cancelling orders
# Gotta factor in partially filled orders
class Order < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :trade_pair
  has_one :exchange, through: :trade_pair

  # === VALIDATIONS ===
  validates :status,
            :buy_or_sell,
            :price,
            :quantity,
            presence: true
  validates :buy_or_sell, inclusion: { in: %w[buy sell] }
  validates :status, inclusion: { in: %w[open filled] }

  # === CALLBACKS ===
  after_update :cancel, if: :stale?
  before_validation :format_status
  before_validation :format_buy_or_sell

  # === DELEGATES ===
  delegate :client, to: :exchange
  delegate :symbol, to: :trade_pair

  def cancel
    case exchange.identifier
    when 'binance'
      result = client.cancel_order!(symbol: symbol.upcase, order_id: reference)
      return if result['code'].present?

      destroy!
    end
  end

  # This only works for 'sell' right now
  def create_counter
    return if buy_or_sell == 'sell'

    next_buy_or_sell = 'sell'
    next_quantity = quantity - trade_pair.amount_step
    next_price = (quantity_received * (1.0 + (taker_fee_for_calculation * 3))) / next_quantity

    raise StandardError, 'check calculations' if next_price <= price
    raise StandardError, 'check calculations' if next_quantity >= quantity

    trade_pair.create_order(next_buy_or_sell, next_price, next_quantity)
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

  # Update this later to be able to handle cancelled orders
  def update_from_exchange
    case exchange.identifier
    when 'binance'
      result = query
      return if result['symbol'].blank?
      return if result['status'] == 'CANCELED'

      update!(status: result['status'].downcase, quantity_received: result['cummulativeQuoteQty'].to_d)
    end
  end

  private

  def format_buy_or_sell
    return if buy_or_sell.blank?

    self.buy_or_sell = buy_or_sell.downcase
  end

  def format_status
    return if status.blank?

    self.status = 'open' if status.downcase == 'new' || status.downcase == 'partially_filled'
    self.status = status.downcase
  end

  def open?
    status == 'open'
  end

  # Currently we only want to remove old buy orders
  def stale?
    buy_or_sell == 'buy' && open? && (quantity_received.nil? || quantity_received.zero?) && (created_at < Time.current - 12.hours)
  end

  def taker_fee_for_calculation
    tf = trade_pair.taker_fee || exchange.taker_fee
    tf / 100
  end
end
