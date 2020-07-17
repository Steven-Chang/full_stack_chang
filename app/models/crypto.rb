# frozen_string_literal: true

class Crypto < ApplicationRecord
  # === ASSOCIATIONS ===
  has_many :crypto_exchanges, dependent: :destroy
  has_many :exchanges, through: :crypto_exchanges
end
