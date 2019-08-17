# frozen_string_literal: true

class Client < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :payment_summaries, dependent: :destroy
  has_many :tranxactions, as: :tranxactable, dependent: :destroy

  # === VALIDATIONS ===
  validates :name, presence: true

  # === INSTANCE METHODS ===
  # for tranxactable dashboard table
  def reference
    name
  end
end
