require 'rails_helper'

RSpec.describe TargetEvaluator, type: :model do
  before(:each) do
    panel_provider = create(:panel_provider)
    @country = create(:country, panel_provider: panel_provider)
    @target_group = create(:target_group)
    @locations = create_list(:location, 3)
    @locations_hash = @locations.map { |location| { 'id' => location.id, 'panel_size' => Faker::Number.number(3) }}
  end

  describe 'valid?' do
    it 'should be valid if correct parameters where provided' do
      target_evaluator = TargetEvaluator.new({country_code: @country.country_code, target_group_id: @target_group.id, locations: @locations_hash})
      expect(target_evaluator.valid?).to be true
    end

    context 'invalid parameters' do
      it 'should be invalid if country_code was not provided' do
        target_evaluator = TargetEvaluator.new({target_group_id: @target_group.id, locations: @locations_hash})
        expect(target_evaluator.valid?).to be false
      end

      it 'should be invalid if target_group_id was not provided' do
        target_evaluator = TargetEvaluator.new({country_code: @country.country_code, locations: @locations_hash})
        expect(target_evaluator.valid?).to be false
      end

      it 'should be invalid if location_hash was not provided' do
        target_evaluator = TargetEvaluator.new({country_code: @country.country_code, target_group_id: @target_group.id})
        expect(target_evaluator.valid?).to be false
      end

      it 'should be invalid if incorrect location_hash was provided' do
        locations_hash = @locations.map { |location| { 'id' => location.id } }
        target_evaluator = TargetEvaluator.new({country_code: @country.country_code, target_group_id: @target_group.id, locations: locations_hash})
        expect(target_evaluator.valid?).to be false
      end
    end
  end

  describe 'prices' do
    before(:each) do
      @target_evaluator = TargetEvaluator.new({country_code: @country.country_code, target_group_id: @target_group.id, locations: @locations_hash})
    end

    it "returns an Array" do
      expect(@target_evaluator.prices).to be_an Array
    end

    it "returns an array of the same size as locations hash" do
      expect(@target_evaluator.prices.size).to eq @locations_hash.size
    end

    it "returns correct provider price" do
      provider_price = ProviderPriceFetcher.new(@country.panel_provider).get_price
      expect(@target_evaluator.prices[0][:provider_price]).to eql provider_price
    end

    it "returns correct total price" do
      provider_price = ProviderPriceFetcher.new(@country.panel_provider).get_price
      total_price = provider_price * @locations_hash[0]['panel_size'].to_i
      expect(@target_evaluator.prices[0][:total_price]).to eql total_price
    end
  end
end
