class TaxCategory < ApplicationRecord
  has_many :tranxactions

  validates :description, uniqueness: { case_sensitive: false }
end
