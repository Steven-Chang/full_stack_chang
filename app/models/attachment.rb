# frozen_string_literal: true

class Attachment < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :resource, polymorphic: true

  # === VALIDATIONS ===
  validates :resource_type, presence: true

  # === ENUMERABLES ===
  enum file_type: { image: 0, raw: 1, video: 2 }
end
