class Api::V1::LocationsController < Api::V1::BaseController
  def index
    render json: @country.locations
  end
end
