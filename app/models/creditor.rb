# frozen_string_literal: true

class Creditor < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :user
	has_many :tranxactions, dependent: :restrict_with_error

	# === VALIDATIONS ===
	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false, scope: :user_id }

	# === CALLBACKS ===
	before_save do |creditor|
		creditor.name = creditor.name.downcase
	end
end
