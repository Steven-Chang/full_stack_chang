class Tranxaction < ApplicationRecord
  has_many :tranxactables
  has_many :attachments
end
