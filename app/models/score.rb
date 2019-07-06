# frozen_string_literal: true

class Score < ApplicationRecord
	# === ASSOCIATIONS ===
  belongs_to :project

  # === VALIDATIONS ===
  validates :name, presence: true
  validates :score, numericality: { only_integer: true }
  validates :level,
            :lines,
            numericality: {
              only_integer: true,
              allow_nil: true
            }
end
