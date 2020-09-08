# frozen_string_literal: true

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

  # Update this later to be able to handle cancelled orders
  def update_from_exchange
    case exchange.identifier
    when 'binance'
      result = client.query_order(symbol: symbol.upcase, order_id: reference)
      return unless result['symbol'].present?
      return if result['status'] == 'CANCELED' 

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

  def map_status
  end
end
