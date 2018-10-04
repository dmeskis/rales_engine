Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      # Merchant Endpoints
      get 'merchants/:id/items', to: 'merchants/items#index'
      get '/merchants/:id/invoices', to: 'merchants/invoices#index'
      # Merchant Business Intelligence
      get 'merchants/:id/revenue', to: 'merchants/revenue#show'
      get 'merchants/:id/favorite_customer', to: 'merchants/favorite_customer#show'
    end
  end
end
