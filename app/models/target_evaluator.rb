class TargetEvaluator
  attr_reader :errors

  def initialize(params)
    @locations_hash = params[:locations]
    @country = Country.find_by(country_code: params[:country_code])
    @target_group = TargetGroup.find(params[:target_group_id])
    @errors = []
  end

  def valid?
    valid_country_code && valid_target_group_id && valid_locations_hash
  end

  def prices
    0
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