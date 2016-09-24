Rails.application.routes.draw do
  namespace :api, defaults: { format: :json  } do
    scope module: :v1 do
      get 'locations/:country_code', to: 'locations#index', as: 'locations'
      get 'target_groups/:country_code', to: 'target_groups#index', as: 'target_groups'

      get 'request_token', to: 'base#request_token#', as: 'request_token'

      namespace :private do
        get 'locations/:country_code', to: 'locations#index', as: 'locations'
        get 'target_groups/:country_code', to: 'target_groups#index', as: 'target_groups'
        post 'evaluate_target', to: 'evaluate_targets#show', as: 'evaluate_target'
      end
    end
  end
end
