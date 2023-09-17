# frozen_string_literal: true

require 'uri'

# Tranxaction
Attachment.where(resource_type: 'Tranxaction').where.not(url: [nil, ""]).limit(1).find_each do |a|
  filename = File.basename(URI.parse(a.url).path)
  file = URI.open(a.url)
  a.resource.attachments.attach(io: file, filename:)
  puts a.resource.id
end
