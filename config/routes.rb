Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      # Merchant Business Intelligence
      get 'merchants/:id/revenue', to: 'merchants/revenue#show'
    end
  end
end
