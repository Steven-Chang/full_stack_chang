# frozen_string_literal: true

class Attachment < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :resource, polymorphic: true

  # === CALLBACKS ===
  after_destroy do |attachment|
    Cloudinary::Uploader.destroy(attachment.cloudinary_public_id) if attachment.cloudinary_public_id
  end

  # === ENUMERABLES ===
  enum file_type: { image: 0, raw: 1, video: 2 }

  # === CLASS METHODS ===
end
