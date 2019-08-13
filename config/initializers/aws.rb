# frozen_string_literal: true

Aws.config.update(
  region: 'ap-southeast-2',
  credentials: Aws::Credentials.new(
    Rails.application.credentials.aws[:AWS_ACCESS_KEY_ID],
    Rails.application.credentials.aws[:AWS_SECRET_ACCESS_KEY]
  )
)
