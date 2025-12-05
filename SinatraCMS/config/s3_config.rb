require 'aws-sdk-s3'
require 'dotenv/load'

class S3Config
  def self.client
    @client ||= Aws::S3::Client.new(
      region: ENV['AWS_REGION'] || 'us-east-1',
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )
  end

  def self.resource
    @resource ||= Aws::S3::Resource.new(
      region: ENV['AWS_REGION'] || 'us-east-1',
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )
  end

  def self.bucket_name
    ENV['S3_BUCKET_NAME']
  end

  def self.bucket
    @bucket ||= resource.bucket(bucket_name)
  end
end