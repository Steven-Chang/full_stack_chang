# frozen_string_literal: true

class Tool < ApplicationRecord
  # === CONSTANTS ===
  CATEGORY_LABEL_MAPPING = {
    app: 'Application & Data',
    crypto: 'Crypto',
    utility: 'Utilities',
    devop: 'DevOps',
    business: 'Business Tools'
  }.freeze

  # === ENUMS ===
  enum category: %i[app crypto utility devop business]

  # === ASSOCIATIONS ===
  has_and_belongs_to_many :projects
  has_many :attachments, as: :resource,
                         dependent: :destroy,
                         inverse_of: :resource

  # === VALIDATIONS ===
  validates :name, uniqueness: { case_sensitive: false }

  # === ACCEPTS_NESTED_ATTRIBUTES_FOR ===
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
