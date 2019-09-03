# frozen_string_literal: true

class Tool < ApplicationRecord
  # === ENUMS ===
  enum category: %i[app utility devop business]

  # === ASSOCIATIONS ===
  has_many :attachments, as: :resource, dependent: :destroy, inverse_of: :resource

  # === VALIDATIONS ===
  validates :name, uniqueness: { case_sensitive: false }
end
