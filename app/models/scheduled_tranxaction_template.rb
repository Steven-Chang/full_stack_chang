# frozen_string_literal: true

class ScheduledTranxactionTemplate < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :creditor
	belongs_to :tax_category, optional: true
	belongs_to :tranxactable, polymorphic: true

	# === VALIDATIONS ===
	validates :amount, numericality: true
  validates :date_offset, numericality: true
	validates :amount, :date, :days_for_recurrence, :description, :tranxactable_type, presence: true

  # === CLASS METHODS ===
  def self.process
    where(enabled: true)
      .find_each do |stt|
        next unless (stt_date = stt.date)
        next unless stt_date <= Date.current + 1.day + stt.date_offset.to_i

        tranxaction = Tranxaction.create(
          amount: stt.amount,
          creditor: stt.creditor,
          date: stt_date,
          description: stt.description,
          tax: stt.tax,
          tax_category: stt.tax_category,
          tranxactable: stt.tranxactable
        )
        next unless tranxaction.persisted?

        next_date_to_process = stt_date + stt.days_for_recurrence.days
        stt.update!(date: next_date_to_process)
		  end
  end
end
