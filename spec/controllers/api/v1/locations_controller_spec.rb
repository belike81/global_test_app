require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      panel_provider = create(:panel_provider)
      country = create(:country, panel_provider: panel_provider)
      location_group = create(:location_group, country: country, panel_provider: panel_provider)
      @location = create(:location, location_groups: [location_group])
      get :index, country_code: country.country_code, format: :json
    end

    it "returns a 200 status-code" do
      expect(response).to be_success
    end

    it "returns locations belonging to the country based on it's current panel provider" do
      json = JSON.parse(response.body)
      expect(json[0]['name']).to eql @location.name
    end
  end
end
