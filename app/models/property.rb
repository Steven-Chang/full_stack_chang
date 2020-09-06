# frozen_string_literal: true

class Property < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :tranxactions, as: :tranxactable, dependent: :restrict_with_error
  has_many :tax_categories, through: :tranxactions
  has_many :tenancy_agreements, dependent: :restrict_with_error

  # === VALIDATIONS ===
  validates :address, presence: true

  # === INSTANCE METHODS ===
  # for tranxactable dashboard table
  def reference
    address
  end
end
