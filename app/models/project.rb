class Project < ApplicationRecord
  has_many :scores, dependent: :destroy
  has_many :attachments, as: :resource, dependent: :destroy
end
