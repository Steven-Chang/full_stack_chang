# frozen_string_literal: true

class CryptoExchange < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :crypto
  belongs_to :exchange

  # === INSTANCE METHODS ===
  # This needs review as calculating money
  def trade_fee_total(quantity, rate, maker_or_taker = 'maker')
    quantity * rate * trade_fee_general(maker_or_taker) / 100
  end

  def trade_fee_general(maker_or_taker)
    case maker_or_taker
    when 'maker'
      maker_fee.present? ? maker_fee : exchange.maker_fee
    when 'taker'
      taker_fee.present? ? taker_fee : exchange.taker_fee
    else
      'enter raise error code here when you get time and is needed'
    end
  end
end
