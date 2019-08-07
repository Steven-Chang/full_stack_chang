# frozen_string_literal: true

class Tranxactable < ApplicationRecord
	# === ASSOCIATIONS ===
  belongs_to :resource, polymorphic: true
  belongs_to :tranxaction
end
