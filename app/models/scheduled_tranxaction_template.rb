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
	def self.process_scheduled_tranxaction_templates
	end
end
