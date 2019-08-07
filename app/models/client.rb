# frozen_string_literal: true

class Client < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :payment_summaries, dependent: :destroy
  has_many :tranxactables, as: :resource, dependent: :destroy
  has_many :tranxactions, as: :tranxactable, dependent: :destroy

  # === VALIDATIONS ===
  validates :name, presence: true
end
