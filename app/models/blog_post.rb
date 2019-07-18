# frozen_string_literal: true

class BlogPost < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :attachments, as: :resource, dependent: :destroy, inverse_of: :resource

  # === VALIDATIONS ===
  validates :date_added,
            :description,
            :title,
            presence: true
end
