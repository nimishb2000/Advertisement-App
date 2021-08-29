class AuthenticationTokenService
  SECRET = 'pNIWIL34Jo13LViZAJACzK6Yf0qnvT_BuwOxiMCPE'
  ENC_TYPE = 'HS256'
  def self.generate(userId)
    payload = { userId: userId}
    token = JWT.encode payload, SECRET, ENC_TYPE
    { token: token }
  end

  def self.check(token)
    decoded_token = JWT.decode token, SECRET, true, { algorithm: ENC_TYPE }
    decoded_token[0]['userId']
  end
end
