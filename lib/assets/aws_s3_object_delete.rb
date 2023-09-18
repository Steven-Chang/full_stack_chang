# frozen_string_literal: true

require 'aws-sdk-s3'

Aws.config.update(region: 'ap-southeast-2', credentials: Aws::Credentials.new(Rails.application.credentials.dig(:aws, :access_key_id), Rails.application.credentials.dig(:aws, :secret_access_key)))

# Project
Attachment.where(resource_type: 'Project').where.not(url: [nil, '']).find_each do |a|
	next unless a.url.include?('full-stack-chang.s3.ap-southeast-2')

  filename = File.basename(URI.parse(a.url).path)
  s3 = Aws::S3::Client.new
  s3.delete_object(bucket: 'full-stack-chang', key: "uploads/#{filename}")
  a.update!(url: nil)
end

# Blog Post
Attachment.where(resource_type: 'BlogPost').where.not(url: [nil, '']).find_each do |a|
    next unless a.url.include?('full-stack-chang.s3.ap-southeast-2')

  filename = File.basename(URI.parse(a.url).path)
  s3 = Aws::S3::Client.new
  s3.delete_object(bucket: 'full-stack-chang', key: "uploads/#{filename}")
  a.update!(url: nil)
end

# object = s3.get_object(bucket: 'full-stack-chang', key: 'uploads/86acafde-70c8-4b2b-a26d-899c34ece6ce.jpeg')

# Attachment.where.not(url: [nil, '']).count
