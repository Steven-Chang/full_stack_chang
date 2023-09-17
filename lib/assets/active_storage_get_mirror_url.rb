# frozen_string_literal: true

# https://github.com/rails/rails/blob/8e939586af1e40d6e2f05429830f54699f51e9e6/activestorage/app/models/active_storage/blob.rb#L229
# Getting the url from a specific mirror
attachment = Tranxaction.last.attachments.first
key = Tranxaction.last.attachments.first.key
mirror = attachment.blob.service.mirrors.first
mirror.url key, expires_in: ActiveStorage.service_urls_expire_in, disposition: 'attachment', filename: attachment.blob.filename, content_type: :attachment
