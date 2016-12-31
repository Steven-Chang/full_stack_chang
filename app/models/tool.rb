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
  enum category: { app: 0, crypto: 1, utility: 2, devop: 3, business: 4 }

  # === ASSOCIATIONS ===
  has_and_belongs_to_many :projects
  has_many :attachments, as: :resource,
                         dependent: :destroy,
                         inverse_of: :resource

  # === VALIDATIONS ===
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  # === ACCEPTS_NESTED_ATTRIBUTES_FOR ===
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
