class Api::V1::TargetGroupsController < Api::V1::BaseController
  def index
    render json: @country.target_groups
  end
end
