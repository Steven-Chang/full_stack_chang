# frozen_string_literal: true

class Exchange < ApplicationRecord
  # === ASSOCIATIONS ===
  has_many :crypto_exchanges, dependent: :destroy
  has_many :cryptos, through: :crypto_exchanges

  # === VALIDATIONS ===
  validates :identifier, :name, presence: true
end
