# frozen_string_literal: true

require 'open-uri'

# Tranxaction
Attachment.where(resource_type: 'Tranxaction').where.not(url: [nil, '']).find_each do |a|
  filename = File.basename(URI.parse(a.url).path)
  file = URI.open(a.url)
  a.resource.attachments.attach(io: file, filename:)
end

# Project
Attachment.where(resource_type: 'Project').where.not(url: [nil, '']).find_each do |a|
  unless a.url.include?('hpxlnqput')
    filename = File.basename(URI.parse(a.url).path)
    puts a.url
    file = URI.open(a.url)
    a.resource.logo.attach(io: file, filename:)
  end
  a.update!(url: nil)
end

# Tranxaction
Attachment.where(resource_type: 'BlogPost').where.not(url: [nil, '']).find_each do |a|
  filename = File.basename(URI.parse(a.url).path)
  file = URI.open(a.url)
  a.resource.attachments.attach(io: file, filename:)
  a.update!(url: nil)
end
