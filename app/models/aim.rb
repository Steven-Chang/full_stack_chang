class Aim < ApplicationRecord
  has_many :entries, dependent: :destroy
end
