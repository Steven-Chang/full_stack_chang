class Project < ApplicationRecord
  has_many :scores, dependent: :destroy
end
