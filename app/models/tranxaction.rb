# frozen_string_literal: true

class Tranxaction < ApplicationRecord
  # === ASSOCIATIONS ===
  has_many :tranxactables, dependent: :destroy
  has_many :attachments, as: :resource, dependent: :destroy
  belongs_to :tax_category

  # === CALLBACKS ===
  after_create do |tranxaction|
    tranxaction.tranxactables.each do |tranxactable|
      next unless tranxactable.resource_type == 'Client'

      # We want to build the work tranxactable
      new_tranxactable = Tranxactable.new
      new_tranxactable.resource_type = 'TranxactionType'
      new_tranxactable.resource_id = TranxactionType.find_by(description: 'work').id
      new_tranxactable.tranxaction_id = tranxaction.id
      new_tranxactable.save
      # Seeing if this even gets called
      raise 'error'
    end
  end

  before_save do |tranxaction|
    tranxaction.tax_category_id = nil unless tranxaction.tax
  end
end
