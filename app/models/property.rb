class Property < ApplicationRecord
  has_many :tenancy_agreements

  has_many :tranxactables, as: :resource
  has_many :tranxactions, through: :tranxactables
  has_many :tax_categories, through: :tranxactions
end
