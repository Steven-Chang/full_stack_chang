# frozen_string_literal: true

class CryptoExchange < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :crypto
  belongs_to :exchange

  # === INSTANCE METHODS ===
  # This needs review as calculating money
  def trade_fee_total(qantity, rate, maker_or_taker)
    quantity * rate * trade_fee_general / 100
  end

  def trade_fee_general(maker_or_taker)
    if maker_or_taker == 'maker'
      maker_fee.present? ? maker_fee : exchange.maker_fee
    else
      taker_fee.present? ? taker_fee : exchange.taker_fee
    end
  end
end
