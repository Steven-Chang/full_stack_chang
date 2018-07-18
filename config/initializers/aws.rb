Aws.config[:credentials] = Aws::Credentials.new(
  ENV['AWS_ACCESS_KEY_ID'],
  ENV['AWS_SECRET_ACCESS_KEY']
)
Aws.config[:region] = 'us-east-1'