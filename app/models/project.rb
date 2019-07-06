# frozen_string_literal: true

class Project < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :scores, dependent: :destroy
  has_many :attachments, as: :resource, dependent: :destroy

  # === VALIDATIONS ===
  validates :title, presence: true
end
