# frozen_string_literal: true

class Project < ApplicationRecord
	# === ASSOCIATIONS ===
  has_one_attached :logo
  has_many :attachments, as: :resource, dependent: :delete_all
  has_and_belongs_to_many :tools

  # === VALIDATIONS ===
  validates :title,
            :start_date,
            presence: true
end
