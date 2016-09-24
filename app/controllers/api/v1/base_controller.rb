class Api::V1::BaseController < ApplicationController
  before_action :ensure_country_is_set

  private

  def ensure_country_is_set
    @country = Country.find_by(country_code: params[:country_code])
    not_found unless @country
  end

  def authenticate_request
    authenticate_token || unauthorized_access
  end

  def unauthorized_access
    render json: 'Not authorized', status: 401
  end

  def not_found
    render json: 'Not found', status: 404
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      Tokenizer.authenticate_token(token)
    end
  end
end