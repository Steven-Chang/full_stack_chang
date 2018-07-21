class Attachment < ApplicationRecord
  belongs_to :resource, polymorphic: true

  after_destroy do |attachment|
    Attachment.aws_client.delete_object({
        bucket: ENV['BUCKET_NAME'],
        key: attachment.aws_key
    })
    # No idea if amazon returns a success or fail?? 
    # Most of the net seems to suggest it doesn't
  end

  def self.aws_client
    Aws::S3::Client.new
  end

  def self.aws_resource
    creds = Aws::Credentials.new( ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'] )
    Aws::S3::Resource.new( region: 'ap-southeast-2', credentials: creds )
  end
end
