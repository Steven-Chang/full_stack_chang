# frozen_string_literal: true

class BlogPost < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many_attached :attachments

  # === VALIDATIONS ===
  validates :date_added,
            :title,
            presence: true
end
