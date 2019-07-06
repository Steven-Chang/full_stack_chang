# frozen_string_literal: true

class TenancyAgreement < ApplicationRecord
	# === ASSOCIATIONS ===
  belongs_to :user
  belongs_to :property
  has_many :tranxactables, as: :resource, dependent: :restrict_with_error
  has_many :tranxactions, -> { order(date: :desc, created_at: :desc) }, through: :tranxactables

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
