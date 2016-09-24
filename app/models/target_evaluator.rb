class TargetEvaluator
  attr_reader :errors

  def initialize(params)
    @locations_hash = params[:locations]
    @country = Country.find_by(country_code: params[:country_code].upcase)
    @target_group = TargetGroup.find_by(id: params[:target_group_id])
    @errors = []
  end

  def valid?
    valid_country_code && valid_target_group_id && valid_locations_hash
  end

  def prices
    provider_price = ProviderPriceFetcher.new(@country.panel_provider).get_price
    @locations_hash.map do |location_hash|
      {
        id: location_hash['id'],
        panel_size: location_hash['panel_size'],
        provider_price: provider_price,
        total_price: provider_price * location_hash['panel_size'].to_i
      }
    end
  end

  private

  def valid_country_code
    if @country
      true
    else
      @errors << 'Country code is invalid'
      false
    end
  end

  def valid_target_group_id
    if @target_group
      true
    else
      @errors << 'Target group id is invalid'
      false
    end
  end

  def valid_locations_hash
    if @locations_hash.is_a?(Array) && locations_hash_params_valid?
      true
    else
      @errors << 'Locations hash is invalid'
      false
    end
  end

  def locations_hash_params_valid?
    @locations_hash.any? && @locations_hash.all? { |obj| obj.keys.include?('id') && obj.keys.include?('panel_size') }
  end

end