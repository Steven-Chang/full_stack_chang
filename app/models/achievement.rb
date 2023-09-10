# frozen_string_literal: true

class Achievement < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :project

  # === VALIDATIONS ===a
  validates :date, :description, :resource_type, presence: true
end
