class Tranxactable < ApplicationRecord
  belongs_to :tranxaction
  belongs_to :resource, polymorphic: true
end
