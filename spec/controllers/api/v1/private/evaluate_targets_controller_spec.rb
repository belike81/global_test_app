require 'rails_helper'

RSpec.describe Api::V1::Private::EvaluateTargetsController, type: :controller do
  describe "POST #show" do
    before(:each) do
      @panel_provider = create(:panel_provider)
      @country = create(:country, panel_provider: @panel_provider)
      location_group = create(:location_group, country: @country, panel_provider: @panel_provider)
      @locations = create_list(:location, 3, location_groups: [location_group])
      @locations_hash = @locations.map { |location| { 'id' => location.id, 'panel_size' => Faker::Number.number(3) }}
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

    context 'valid token' do
      before(:each) do
        token = Tokenizer.generate_token
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
        post :show, { country_code: @country.country_code, target_group_id: @target_group.id, locations: @locations_hash}
        @json = JSON.parse(response.body)
      end

      it "let's the request true if correct token has been provided" do
        expect(response).to be_success
      end

      it "display's correct number of prices for provided locations" do
        expect(@json.size).to eql @locations.size
      end

      it "display's correct price for Provider" do
        provider_price = ProviderPriceFetcher.new(@panel_provider).get_price
        expect(@json[0]['provider_price']).to eql provider_price
      end

      it "display's correct total price for Provider & Location" do
        provider_price = ProviderPriceFetcher.new(@panel_provider).get_price
        total_price = provider_price * @locations_hash[0]['panel_size'].to_i
        expect(@json[0]['total_price']).to eql total_price
      end
    end
  end
end
