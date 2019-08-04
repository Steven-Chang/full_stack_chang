# frozen_string_literal: true

class Attachment < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :resource, polymorphic: true

  # === CALLBACKS ===
  after_destroy do |attachment|
    # No idea if amazon returns a success or fail??
    # Most of the net seems to suggest it doesn't
    Attachment.aws_client.delete_object(
      bucket: Rails.application.credentials.aws[:bucket_name],
      key: attachment.aws_key
    )
  end

  # === ENUMERABLES ===
  enum file_type: { image: 0, raw: 1, video: 2 }

  # === CLASS METHODS ===
  def self.aws_client
    Aws::S3::Client.new
  end

  def self.aws_resource
    aws_access_key_id = Rails.application.credentials.aws[:access_key_id]
    aws_secret_access_key = Rails.application.credentials.aws[:secret_access_key]
    creds = Aws::Credentials.new(aws_access_key_id, aws_secret_access_key)
    Aws::S3::Resource.new(region: 'ap-southeast-2', credentials: creds)
  end
end
