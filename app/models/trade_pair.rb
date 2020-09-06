# frozen_string_literal: true

# maker_fee and taker_fee to be the percentage amount
class TradePair < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :exchange

  # === VALIDATIONS ===
  validates :symbol, presence: true
  validates :symbol, uniqueness: { case_sensitive: false, scope: :exchange_id }

  # === CALLBACKS ===
  before_save { symbol.downcase! }

  # === INSTANCE METHODS ===

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
end
