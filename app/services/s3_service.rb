require 'aws-sdk-s3'

class S3Service
  def initialize
    @s3_client = Aws::S3::Client.new(
      region: 'us-west-2',
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )
  end

  def presigned_url(object_key)
    object_key = object_key.sub(%r{^/}, '')  # Remove leading slash if present
    signer = Aws::S3::Presigner.new(client: @s3_client)
    signer.presigned_url(:get_object, bucket: 'startupsonrails-bucket-development', key: object_key)
  end

  def object_key_exists?(object_key)
    begin
      @s3_client.head_object(bucket: 'startupsonrails-bucket-development', key: object_key)
      true
    rescue Aws::S3::Errors::NotFound
      false
    end
  end
end
