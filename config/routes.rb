Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      # Merchant Endpoints
      get 'merchants/:id/items', to: 'merchants/items#index'
      get 'merchants/:id/invoices', to: 'merchants/invoices#index'
      # Merchant Business Intelligence
      get 'merchants/:id/revenue', to: 'merchants/revenue#show'
      get 'merchants/:id/favorite_customer', to: 'merchants/favorite_customer#show'

      # Transaction Endpoints
      get 'invoices/:id/transactions', to: 'invoices/transactions#index'
      get 'invoices/:id/invoice_items', to: 'invoices/invoice_items#index'
      get 'invoices/:id/items', to: 'invoices/items#index'
      get 'invoices/:id/customer', to: 'invoices/customer#show'
      get 'invoices/:id/merchant', to: 'invoices/merchant#show'
    end
  end
end
