# frozen_string_literal: true

class Creditor < ApplicationRecord
	# === ASSOCIATIONS ===
	has_many :tranxactions, dependent: :restrict_with_error

	# === VALIDATIONS ===
	validates :name, uniqueness: { case_sensitive: false }
end
