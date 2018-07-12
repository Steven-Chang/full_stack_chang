class TenancyAgreement < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_many :tranxactables, as: :resource
  has_many :tranxactions, through: :tranxactables
end
