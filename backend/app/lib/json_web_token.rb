class JsonWebToken
  SECRET_KEY = ENV['JWT_SECRET'] || 'fallback_secret'

  # JWT 토큰 생성
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i  # 만료 시간 설정
    JWT.encode(payload, SECRET_KEY)
  end

  # JWT 토큰 해석
  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::DecodeError
    nil  # 유효하지 않은 토큰일 경우 nil 반환
  end
end
