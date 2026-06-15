module LegacyPasswordAuthenticatable
  extend ActiveSupport::Concern

  ASPNET_V2_LENGTH = 36
  ASPNET_V3_MIN_LENGTH = 61
  ASPNET_V3_MARKER = 0x01

  def authenticate(unhashed_password)
    return false if password_digest.blank?

    if password_digest.start_with?("$2a$")
      super
    else
      verify_legacy_hash(unhashed_password)
    end
  end

  private

  def verify_legacy_hash(password)
    decoded = Base64.strict_decode64(password_digest)
    byte_size = decoded.bytesize

    if byte_size >= ASPNET_V3_MIN_LENGTH && decoded[0].unpack1("C") == ASPNET_V3_MARKER
      verify_aspnet_v3(password, decoded)
    elsif byte_size == ASPNET_V2_LENGTH
      verify_aspnet_v2(password, decoded)
    else
      false
    end
  rescue ArgumentError
    false
  end

  def verify_aspnet_v3(password, decoded)
    prf_num    = decoded[1..4].unpack1("N")
    iterations = decoded[5..8].unpack1("N")
    salt_len   = decoded[9..12].unpack1("N")
    salt       = decoded[13, salt_len]
    stored_key = decoded[(13 + salt_len)..]

    prf = case prf_num
          when 0 then OpenSSL::Digest::SHA1
          when 1 then OpenSSL::Digest::SHA256
          when 2 then OpenSSL::Digest::SHA512
          else return false
          end

    derived_key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, iterations, stored_key.bytesize, prf)
    ActiveSupport::SecurityUtils.secure_compare(derived_key, stored_key)
  end

  def verify_aspnet_v2(password, decoded)
    salt       = decoded[0..15]
    stored_key = decoded[16..35]

    derived_key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, 1000, 20, OpenSSL::Digest::SHA1.new)
    ActiveSupport::SecurityUtils.secure_compare(derived_key, stored_key)
  end
end
