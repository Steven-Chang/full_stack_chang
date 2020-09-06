# frozen_string_literal: true

class Order < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :trade_pair
end
