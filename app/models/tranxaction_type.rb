class TranxactionType < ApplicationRecord
  has_many :tranxactables, as: :resource
  has_many :tranxactions, through: :tranxactables
end
