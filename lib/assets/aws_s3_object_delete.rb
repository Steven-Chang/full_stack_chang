# Deleting S3
# Aws.config.update(
#   region: 'ap-southeast-2',
#   credentials: Aws::Credentials.new(Rails.application.credentials.dig(:aws, :access_key_id), Rails.application.credentials.dig(:aws, :secret_access_key)
# )
# Attachment.where(resource_type: 'Tranxaction').where.not(url: [nil, ""]).find_each do |a|
#    filename = File.basename(URI.parse(a.url).path)
#    s3.delete_object(bucket: 'full-stack-chang', key:
#    "uploads/#{filename}")
#    a.update!(url: nil)
# end
# object = s3.get_object(bucket: 'full-stack-chang', key: 'uploads/86acafde-70c8-4b2b-a26d-899c34ece6ce.jpeg')

Attachment.where.not(url: [nil, '']).count
