# frozen_string_literal: true

class TenancyAgreement < ApplicationRecord
	# === ASSOCIATIONS ===
  belongs_to :user
  belongs_to :property
  has_many :tranxactions, -> { order(date: :desc, created_at: :desc) }, as: :tranxactable, inverse_of: :tranxactable

  # === VALIDATIONS ===
  validates :amount, numericality: true
  validates :bond, numericality: {
    allow_nil: true
  }
  validates :starting_date, presence: true

  # === INSTANCE METHODS ===
  def balance
    tranxactions.sum(:amount)
  end
end
