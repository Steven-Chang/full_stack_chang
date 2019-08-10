# frozen_string_literal: true

class ScheduledTranxactionTemplate < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :creditor
	belongs_to :tax_category
	belongs_to :tranxactable, polymorphic: true

	# === VALIDATIONS ===
	validates :amount, numericality: true
	validates :date, :days_for_recurrence, :tranxactable, presence: true

  # === CLASS METHODS ===
  def self.process
    where(enabled: true)
      .where('date <= ?', Date.current)
      .find_each do |scheduled_tranxaction_template|
        tranxaction = Tranxaction.create(
          amount: scheduled_tranxaction_template.amount,
          creditor: scheduled_tranxaction_template.creditor,
          date: scheduled_tranxaction_template.date,
          description: scheduled_tranxaction_template.description,
          tax: scheduled_tranxaction_template.tax,
          tax_category: scheduled_tranxaction_template.tax_category,
          tranxactable: scheduled_tranxaction_template.tranxactable
        )
        next unless tranxaction.persisted?

        next_date_to_process = scheduled_tranxaction_template.date + scheduled_tranxaction_template.days_for_recurrence.days
        scheduled_tranxaction_template.update!(date: next_date_to_process)
		  end
  end
end
