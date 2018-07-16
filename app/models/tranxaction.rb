class Tranxaction < ApplicationRecord
  has_many :attachments
  has_many :tranxactables
end
