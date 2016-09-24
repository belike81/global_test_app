Rails.application.routes.draw do
  namespace :api, defaults: { format: :json  } do
    scope module: :v1 do
      get 'locations/:country_code', to: 'locations#index', as: 'locations'
      get 'target_groups/:country_code', to: 'target_groups#index', as: 'target_groups'

      namespace :private do
        get 'locations/:country_code', to: 'locations#index', as: 'locations'
        get 'target_groups/:country_code', to: 'target_groups#index', as: 'target_groups'
      end
    end
  end
end
