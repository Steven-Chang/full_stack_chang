# frozen_string_literal: true

class Tranxaction < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :creditor
  belongs_to :tax_category
  belongs_to :tranxactable, polymorphic: true
  has_many :attachments, as: :resource, dependent: :destroy

  # === ACCEPTS_NESTED_ATTRIBUTES_FOR ===
  accepts_nested_attributes_for :attachments, allow_destroy: true

  # === CALLBACKS ===
  before_save do |tranxaction|
    tranxaction.tax_category_id = nil unless tranxaction.tax
  end
end
