require 'rails_helper'

RSpec.describe Api::V1::Private::EvaluateTargetsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @panel_provider = create(:panel_provider)
      @country = create(:country, panel_provider: @panel_provider)
      location_group = create(:location_group, country: @country, panel_provider: @panel_provider)
      @locations = create_list(:location, 3, location_groups: [location_group])
      @locations_hash = @locations.map { |location| { id: location.id, panel_size: Faker::Number.number(3) }}
      @target_group = create(:target_group, panel_provider: @panel_provider)
    end

    it "returns an error code if no token has been provided" do
      post :show, { country_code: @country.country_code, target_group_id: @target_group.id, locations: @locations_hash}
      expect(response).not_to be_success
    end

    it "returns an error code if incorrect token has been provided" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials('invalid_token')
      post :show, { country_code: @country.country_code, target_group_id: @target_group.id, locations: @locations_hash}
      expect(response).not_to be_success
    end

    it "let's the request true if correct token has been provided" do
      token = Tokenizer.generate_token
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
      post :show, { country_code: @country.country_code, target_group_id: @target_group.id, locations: @locations_hash}
      expect(response).to be_success
    end
  end
end
