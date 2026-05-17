require "net/http"
require "uri"

class SupabaseStorageService
  SUPABASE_URL = "https://laxobptskpcksdrnvaxp.supabase.co"
  BUCKET = "images"

  def self.upload(file, path)
    new.upload(file, path)
  end

  def upload(file, path)
    service_key = ENV["SUPABASE_SERVICE_ROLE_KEY"]
    raise "SUPABASE_SERVICE_ROLE_KEY not set" if service_key.blank?

    uri = URI.parse("#{SUPABASE_URL}/storage/v1/object/#{BUCKET}/#{path}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.read_timeout = 30

    request = Net::HTTP::Post.new(uri.request_uri)
    request["apikey"] = service_key
    request["Authorization"] = "Bearer #{service_key}"
    request["Content-Type"] = content_type_for(file)
    request["x-upsert"] = "true"
    request.body = file.read

    response = http.request(request)

    if response.code.to_i.between?(200, 299)
      public_url(path)
    else
      Rails.logger.error("Supabase Storage upload failed: #{response.code} - #{response.body}")
      nil
    end
  end

  private

  def public_url(path)
    "#{SUPABASE_URL}/storage/v1/object/public/#{BUCKET}/#{path}"
  end

  def content_type_for(file)
    if file.respond_to?(:content_type)
      file.content_type
    else
      "application/octet-stream"
    end
  end
end
