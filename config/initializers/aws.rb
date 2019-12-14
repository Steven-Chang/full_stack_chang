# frozen_string_literal: true

Aws.config.update(
  region: 'ap-southeast-2',
  credentials: Aws::Credentials.new(
    Rails.application.credentials.aws[:access_key_id],
    Rails.application.credentials.aws[:secret_access_key]
  )
)
