# frozen_string_literal: true

class CryptoExchange < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :crypto
  belongs_to :exchange
end
