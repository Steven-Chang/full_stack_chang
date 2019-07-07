# frozen_string_literal: true

class TranxactionType < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :tranxactables, as: :resource, dependent: :destroy
  has_many :tranxactions, through: :tranxactables

  # === VALIDATIONS ===
  validates :description, presence: true
end
