# frozen_string_literal: true

class User < ApplicationRecord
  # === DEVISE ===
  devise :two_factor_authenticatable, :recoverable, :trackable, :timeoutable

  # === ASSOCIATIONS ===
  has_many :tenancy_agreements, dependent: :restrict_with_error
  has_many :tranxactions, through: :tenancy_agreements

  # === VALIDATIONS ===
  validates :email, :encrypted_password, :sign_in_count, presence: true
end
