# frozen_string_literal: true

class User < ApplicationRecord
  # === DEVISE ===
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # === ASSOCIATIONS ===
  has_many :tenancy_agreements, dependent: :restrict_with_error
  has_many :tranxactables, as: :resource, dependent: :restrict_with_error
  has_many :tranxactions, through: :tranxactables

  # === INSTANCE METHODS ===
  def admin?
  	%w[prime_pork@hotmail.com stevenchang5000@gmail.com].include?(email)
  end
end
