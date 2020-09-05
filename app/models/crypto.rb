# frozen_string_literal: true

class Crypto < ApplicationRecord
  # === VALIDATIONS ===
  validates :identifier, :name, presence: true

  # === CALLBACKS ===
  before_save { identifier.downcase! }
end
