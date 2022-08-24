# frozen_string_literal: true

# A note about cancelling orders
# Gotta factor in partially filled orders
class Order < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :parent_order, class_name: 'Order', optional: true, foreign_key: 'order_id', inverse_of: :child_order
  belongs_to :trade_pair
  has_one :credential, through: :trade_pair
  has_one :exchange, through: :trade_pair
  has_one :child_order, class_name: 'Order', dependent: :nullify, inverse_of: :parent_order

  # === ENUMERABLES ===
  enum status: { open: 'open', filled: 'filled', cancelled_stale: 'cancelled_stale', partially_filled: 'partially_filled' }

  # === VALIDATIONS ===
  validates :status,
            :buy_or_sell,
            :price,
            :quantity,
            presence: true
  validates :buy_or_sell, inclusion: { in: %w[buy sell] }

  # === CALLBACKS ===
  before_save :update_status
  after_save :create_counter
  before_validation :format_buy_or_sell

  # === DELEGATES ===
  delegate :symbol,
           :client, to: :trade_pair

  # === SCOPES ===
  scope :buy, lambda { where(buy_or_sell: 'buy') }
  scope :sell, lambda { where(buy_or_sell: 'sell') }

  # === INSTANCE METHODS ===
  def cancel
    case exchange.identifier
    when 'binance'
      result = client.cancel_order!(symbol: symbol.upcase, order_id: reference)
      return if result['code'].present?

      update!(status: 'cancelled_stale')
    end
  end

  def query
    case exchange.identifier
    when 'binance'
      client.query_order(symbol: symbol.upcase, order_id: reference)
    end
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
          self.quantity_received = cummulative_quote_qty
          save!
        end
      else
        self.quantity_received = cummulative_quote_qty
        save!
      end
    end
  end

  private

    def create_counter
      return if buy_or_sell == 'sell'
      return if child_order.present?
      return unless filled? && quantity == quantity_received
      return unless %w[accumulate counter_only].include?(trade_pair.mode)
      return unless trade_pair.exchange.identifier == 'binance'

      next_buy_or_sell = 'sell'
      next_quantity = quantity.to_d - (trade_pair.accumulate_amount || trade_pair.amount_step)
      next_price = (quantity_received.to_d * (1.0 + (taker_fee_for_calculation * 10))) / next_quantity

      raise StandardError, 'Next price should be higher than current price' if next_price <= price
      raise StandardError, 'Next quantity should be less than or equal to current quantity' if next_quantity > quantity

      trade_pair.create_order(next_buy_or_sell, next_price, next_quantity, id)
    end

    def format_buy_or_sell
      return if buy_or_sell.blank?

      self.buy_or_sell = buy_or_sell.downcase
    end

    # filled is misleading because it says filled even when not completely filled
    def update_status
      return unless will_save_change_to_quantity_received?
      return if status == 'cancelled'
      return unless quantity_received.positive?

      self.status = 'filled'
    end
end
