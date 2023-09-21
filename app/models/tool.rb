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
  has_one_attached :logo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many_attached :attachments

  # === VALIDATIONS ===
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
