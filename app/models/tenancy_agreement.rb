# frozen_string_literal: true

class TenancyAgreement < ApplicationRecord
	# === ASSOCIATIONS ===
  belongs_to :user
  belongs_to :property
  has_many :tranxactions, lambda { order(date: :desc, created_at: :desc) }, as: :tranxactable, inverse_of: :tranxactable, dependent: :restrict_with_exception

  # === VALIDATIONS ===
  validates :amount, numericality: true
  validates :bond, numericality: {
    allow_nil: true
  }
  validates :amount, :starting_date, presence: true

  # === INSTANCE METHODS ===
  def balance
    tranxactions.sum(:amount)
  end

  # === INSTANCE METHODS ===
  # for tranxactable dashboard table
  def reference
    "#{user.username || user.email}: #{property.address}"
  end
end
