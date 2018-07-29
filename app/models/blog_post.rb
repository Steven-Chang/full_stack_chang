class BlogPost < ApplicationRecord
  has_and_belongs_to_many :tags
  has_many :attachments, as: :resource, dependent: :destroy
end
