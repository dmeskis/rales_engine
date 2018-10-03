Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      # Merchant Business Intelligence
      get 'merchants/:id/revenue', to: 'merchants/revenue#show'
      get 'merchants/:id/favorite_customer', to: 'merchants/favorite_customer#show'
    end
  end
end
