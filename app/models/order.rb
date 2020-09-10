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
  before_validation :format_status
  before_validation :format_buy_or_sell

  # === DELEGATES ===
  delegate :client, to: :exchange
  delegate :symbol, to: :trade_pair

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

    self.status = 'open' if status.downcase == 'new'
    self.status = status.downcase
  end
end
