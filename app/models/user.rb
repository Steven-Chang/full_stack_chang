# frozen_string_literal: true

class User < ApplicationRecord
  # === DEVISE ===
  devise :recoverable, :trackable, :timeoutable
  devise :two_factor_authenticatable, otp_secret_encryption_key: Rails.application.credentials.two_factor_encryption_key

  # === ASSOCIATIONS ===
  has_many :tenancy_agreements, dependent: :restrict_with_error
  has_many :tranxactions, through: :tenancy_agreements

  # === INSTANCE METHODS ===
  def admin?
  	%w[prime_pork@hotmail.com stevenchang5000@gmail.com].include?(email)
  end
end
