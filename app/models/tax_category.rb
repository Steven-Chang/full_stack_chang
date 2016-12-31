# frozen_string_literal: true

class TaxCategory < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :tranxactions, dependent: :restrict_with_error

  # === VALIDATIONS ===
  validates :description, uniqueness: { case_sensitive: false }
end
