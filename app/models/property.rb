# frozen_string_literal: true

class Property < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :tax_categories, through: :tranxactions
  has_many :tenancy_agreements, dependent: :restrict_with_error
  has_many :tranxactables, as: :resource, dependent: :restrict_with_error
  has_many :tranxactions, through: :tranxactables

  # === VALIDATIONS ===
  validates :address, presence: true
end
