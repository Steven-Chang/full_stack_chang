# frozen_string_literal: true

class Project < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :achievements, dependent: :destroy
  has_many :attachments, as: :resource, dependent: :destroy
  has_and_belongs_to_many :tools

  # === VALIDATIONS ===
  validates :title,
            :start_date,
            presence: true
end
