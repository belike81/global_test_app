Rails.application.routes.draw do
  namespace :api, defaults: { format: :json  } do
    scope module: :v1 do
      get 'locations/:country_code', to: 'locations#index', as: 'locations'
    end
  end
end
