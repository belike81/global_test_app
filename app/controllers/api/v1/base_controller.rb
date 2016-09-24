class Api::V1::BaseController < ApplicationController
  before_action :ensure_country_is_set

  private

  def ensure_country_is_set
    @country = Country.find_by(country_code: params[:country_code])
    head(:country_not_found) unless @country
  end
end