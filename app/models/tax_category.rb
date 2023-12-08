# frozen_string_literal: true

class TaxCategory < ApplicationRecord
  # === ALIAS ATTRIBUTE ===
  alias_attribute :name, :description

	# === ASSOCIATIONS ===
  has_many :tranxactions, dependent: :restrict_with_error

  # === DEFAULT SCOPE ===
  default_scope { order(:description) }

  # === VALIDATIONS ===
  validates :description, presence: true
  validates :description, uniqueness: { case_sensitive: false }
end
