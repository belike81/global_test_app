class Tokenizer < ActiveRecord::Base
  validates_presence_of :token

  class << self
    def generate_token(auth_string = 'test_api_token')
      tokenizer = new(token: JsonWebToken.encode({auth_string: auth_string}))
      tokenizer.save ? tokenizer.token : false
    end

    def authenticate_token(token, auth_string = 'test_api_token')
      found_token = find_by(token: token)

      if found_token && authenticated_with_string(token, auth_string)
        true
      else
        false
      end
    end

  end

  private

  def self.authenticated_with_string(token, auth_string)
    decoded_token = JsonWebToken.decode(token)
    decoded_token[:auth_string] == auth_string ? true : false
  end
end
