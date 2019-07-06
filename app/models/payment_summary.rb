# frozen_string_literal: true

class PaymentSummary < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :client
	has_many :attachments, as: :resource, dependent: :destroy

	# === VALIDATIONS ===
	validates :client_id, uniqueness: { scope: :year_ending }
	validates :year_ending, numericality: { only_integer: true }

  # === INSTANCE METHODS ===
	def gross_payment
    client.tranxactions
          .where(tax: true)
          .where('amount > ?', 0)
          .where('date >= ?', Date.new(year_ending - 1, 7, 1))
          .where('date < ?', Date.new(year_ending, 7, 1))
          .sum(:amount)
	end

  def total_expenses
    client.tranxactions
          .where(tax: true)
          .where('amount < ?', 0)
          .where('date >= ?', Date.new(year_ending - 1, 7, 1))
          .where('date < ?', Date.new(year_ending, 7, 1))
          .sum(:amount)
  end
end
