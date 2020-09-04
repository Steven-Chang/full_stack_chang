# frozen_string_literal: true

class CryptoExchange < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :crypto
  belongs_to :exchange

  # === VALIDATIONS ===
  validates :symbol, presence: true
  validates :symbol, uniqueness: { case_sensitive: false, scope: :exchange_id }

  # === CALLBACKS ===
  before_save { symbol.downcase! }
end
