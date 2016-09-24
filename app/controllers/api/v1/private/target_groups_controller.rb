class Api::V1::Private::TargetGroupsController < Api::V1::TargetGroupsController
  before_action :authenticate_request
end
