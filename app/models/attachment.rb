# frozen_string_literal: true

class Attachment < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :resource, polymorphic: true

  # === VALIDATES ===
  validate :url_should_be_blank_when_cloudinary_public_id_present

  # === CALLBACKS ===
  after_destroy do |attachment|
    Cloudinary::Uploader.destroy(attachment.cloudinary_public_id) if attachment.cloudinary_public_id
  end

  # === ENUMERABLES ===
  enum file_type: { image: 0, raw: 1, video: 2 }

  # === INSTANCE METHODS ===
  def cloudinary_url(options = {})
    return if cloudinary_public_id.blank?

    Cloudinary::Utils.cloudinary_url(cloudinary_public_id, options)
  end

  private

  def url_should_be_blank_when_cloudinary_public_id_present
    return if cloudinary_public_id.present? && url.present?

    errors.add :url, :unnecessary, message: 'please use cloudinary_url instead.'
  end
end
