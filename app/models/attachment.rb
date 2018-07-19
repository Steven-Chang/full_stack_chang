class Attachment < ApplicationRecord
  belongs_to :resource, polymorphic: true
end
