# frozen_string_literal: true

class Creditor < ApplicationRecord
	include AdminDisplayable

  # === DELEGATES ===
  delegate :name, to: :user, prefix: true

	# === ASSOCIATIONS ===
	belongs_to :user
	has_many :tranxactions, dependent: :restrict_with_error

  # === DEFAULT SCOPE ===
  default_scope { order(:name) }

	# === VALIDATIONS ===
	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false, scope: :user_id }

	# === CALLBACKS ===
	before_save do |creditor|
		creditor.name = creditor.name.downcase
	end
end
