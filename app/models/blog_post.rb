# frozen_string_literal: true

class BlogPost < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :attachments, as: :resource, dependent: :destroy, inverse_of: :resource

  # === VALIDATIONS ===
  validates :date_added,
            :description,
            :title,
            presence: true

  # === ACCEPTS_NESTED_ATTRIBUTES_FOR ===
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
