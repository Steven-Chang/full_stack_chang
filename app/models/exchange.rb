# frozen_string_literal: true

class Exchange < ApplicationRecord
  # === ASSOCIATIONS ===
  has_many :trade_pairs, dependent: :destroy

  # === VALIDATIONS ===
  validates :identifier, :name, presence: true
end
