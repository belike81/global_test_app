class Api::V1::Private::EvaluateTargetsController < Api::V1::LocationsController
  skip_before_action :ensure_country_is_set
  before_action :authenticate_request

  def show
    target_evaluator = TargetEvaluator.new(params)
    if target_evaluator.valid?
      render json: target_evaluator.prices
    else
      render json: target_evaluator.errors, status: 401
    end
  end
end
