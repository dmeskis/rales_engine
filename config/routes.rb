Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      # Merchant Endpoints
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/find_all', to: 'merchants/search#index'
      get 'merchants/random', to: 'merchants/random#show'
      get 'merchants/:id/items', to: 'merchants/items#index'
      get 'merchants/:id/invoices', to: 'merchants/invoices#index'
      resources :merchants, only: [:index, :show]
      # Merchant Business Intelligence
      get 'merchants/:id/revenue', to: 'merchants/revenue#show'
      get 'merchants/:id/favorite_customer', to: 'merchants/favorite_customer#show'



      # Transaction Endpoints
      get 'invoices/:id/transactions', to: 'invoices/transactions#index'
      get 'invoices/:id/invoice_items', to: 'invoices/invoice_items#index'
      get 'invoices/:id/items', to: 'invoices/items#index'
      get 'invoices/:id/customer', to: 'invoices/customers#show'
      get 'invoices/:id/merchant', to: 'invoices/merchants#show'

      # Invoice Items Endpoints
      get 'invoice_items/:id/invoice', to: 'invoice_items/invoices#show'
      get 'invoice_items/:id/item', to: 'invoice_items/items#show'

      # Items Endpoints
      get 'items/:id/invoice_items', to: 'items/invoice_items#index'
      get 'items/:id/merchant', to: 'items/merchants#show'

      # Transactions Endpoints
      get 'transactions/:id/invoice', to: 'transactions/invoices#show'

      # Customer Endpoints
      get 'customers/:id/invoices', to: 'customers/invoices#index'
      get 'customers/:id/transactions', to: 'customers/transactions#index'
    end
  end
end
