class JsonWebToken
    def self.encode(payload)
        JWT.encode payload, Rails.application.secret_key_base
    end

    def self.decode(token)
        Jwt.decode(token, Rails.application.secret_key_base).first
    end
end