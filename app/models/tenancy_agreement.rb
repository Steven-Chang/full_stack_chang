class TenancyAgreement < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_many :tranxactables, as: :resource
  has_many :tranxactions, -> { order( date: :desc, created_at: :desc ) }, through: :tranxactables
end
