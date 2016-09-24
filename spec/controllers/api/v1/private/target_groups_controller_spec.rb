require 'rails_helper'

RSpec.describe Api::V1::Private::TargetGroupsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @country = create(:country)
    end

    it "returns an error code if no token has been provided" do
      get :index, country_code: @country.country_code, format: :json
      expect(response).not_to be_success
    end

    it "returns an error code if incorrect token has been provided" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials('invalid_token')
      get :index, country_code: @country.country_code, format: :json
      expect(response).not_to be_success
    end

    it "let's the request true if correct token has been provided" do
      token = Tokenizer.generate_token
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
      get :index, country_code: @country.country_code, format: :json
      expect(response).to be_success
    end
  end
end
