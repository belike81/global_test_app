class Api::V1::Private::LocationsController < Api::V1::LocationsController
  before_action :authenticate_request
end
