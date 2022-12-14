# lib/json_web_token
class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  # class methods (similar to static functions in C++)
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i

      JWT.encode(payload, HMAC_SECRET)
    end

    def decode(token)
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::DecodeError => e
      raise ExceptionHandler::InvalidToken, e.message
    end
  end
end
