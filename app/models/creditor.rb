# frozen_string_literal: true

class Creditor < ApplicationRecord
	# === ASSOCIATIONS ===
	has_many :tranxactions, dependent: :restrict_with_error

	# === VALIDATIONS ===
	validates :name, uniqueness: { case_sensitive: false }

	# === CALLBACKS ===
	before_save do |creditor|
		creditor.name = creditor.name.downcase
	end
end
