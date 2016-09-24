require 'rails_helper'

RSpec.describe Tokenizer, type: :model do
  describe 'generate_token' do
    it 'generates and saves a correct token to the database' do
      token = Tokenizer.generate_token
      expect(Tokenizer.exists?(token: token)).to be true
    end
  end

  describe 'authenticate_token' do
    before(:each) do
      @token = Tokenizer.generate_token('correct string')
    end

    it 'returns true if correct token and auth string is given' do
      response = Tokenizer.authenticate_token(@token, 'correct string')
      expect(response).to be true
    end

    it 'returns false if incorrect token is given' do
      response = Tokenizer.authenticate_token('wrong token')
      expect(response).to be false
    end

    it 'returns false if correct token and incorrect auth string is given' do
      response = Tokenizer.authenticate_token(@token, 'incorrect string')
      expect(response).to be false
    end
  end
end
