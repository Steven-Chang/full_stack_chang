# frozen_string_literal: true

class Order < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :trade_pair

  # === VALIDATIONS ===
  validates :status,
            :buy_or_sell,
            :price,
            :quantity,
            presence: true
  validates :buy_or_sell, inclusion: { in: %w[buy sell] }
  validates :status, inclusion: { in: %w[open filled] }

  # === CALLBACKS ===
  before_save do
    status.downcase!
    buy_or_sell.downcase!
  end
end
