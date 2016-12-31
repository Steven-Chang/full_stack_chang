# frozen_string_literal: true

class Achievement < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :project

  # === VALIDATIONS ===
  validates :date, :description, presence: true
end
