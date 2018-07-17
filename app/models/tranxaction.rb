class Tranxaction < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  has_many :tranxactables
end
