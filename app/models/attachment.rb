class Attachment < ApplicationRecord
  belongs_to :resource, polymorphic: true

  def self.aws_resource
    creds = Aws::Credentials.new( ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'] )
    Aws::S3::Resource.new( region: 'ap-southeast-2', credentials: creds )
  end
end
