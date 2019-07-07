# frozen_string_literal: true

class Tranxactable < ApplicationRecord
	# === ASSOCIATIONS ===
  belongs_to :tranxaction
  belongs_to :resource, polymorphic: true
end
