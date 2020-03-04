Attachment.all.find_each do |a|
  next if a.aws_key.blank? || a.cloudinary_public_id.present?

  a.update!(cloudinary_public_id: a.aws_key)
  url = URI.parse("http://res.cloudinary.com/hpxlnqput/image/upload/temporary%20-%20delete%20daily/#{a.cloudinary_public_id}")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  puts res.body
end
