# frozen_string_literal: true

class Client < ApplicationRecord
  include AdminDisplayable

  # === ALIAS ATTRIBUTE ===
  alias_attribute :reference, :name

	# === ASSOCIATIONS ===
  belongs_to :user
  has_many :payment_summaries, dependent: :destroy
  has_many :tranxactions, as: :tranxactable, dependent: :restrict_with_exception

  # === DEFAULT SCOPE ===
  default_scope { order(:name) }

  # === DELEGATES ===
  delegate :name, to: :user, prefix: true

  # === VALIDATIONS ===
  validates :name, presence: true
end
