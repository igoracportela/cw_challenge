Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' }, constraints: { format: 'json' } do
    namespace :v1 do
      resources :transactions, only: :create
    end
  end
end
