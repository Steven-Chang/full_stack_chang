class TaxCategory < ApplicationRecord
  has_many :tranxactions

  validates :description, uniqueness: true
end
