Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      # Merchant Endpoints
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/find_all', to: 'merchants/search#index'
      get 'merchants/random', to: 'merchants/random#show'
      get 'merchants/:id/items', to: 'merchants/items#index'
      get 'merchants/:id/invoices', to: 'merchants/invoices#index'
      # Merchant Business Intelligence
      get 'merchants/revenue', to: 'merchants/revenue#index'
      get 'merchants/most_revenue', to: 'merchants/most_revenue#index'
      get 'merchants/most_items', to: 'merchants/most_items#index'
      get 'merchants/:id/revenue', to: 'merchants/revenue#show'
      get 'merchants/:id/favorite_customer', to: 'merchants/favorite_customer#show'
      resources :merchants, only: [:index, :show]



      # Invoice Endpoints
      get 'invoices/find', to: 'invoices/search#show'
      get 'invoices/find_all', to: 'invoices/search#index'
      get 'invoices/:id/transactions', to: 'invoices/transactions#index'
      get 'invoices/:id/invoice_items', to: 'invoices/invoice_items#index'
      get 'invoices/:id/items', to: 'invoices/items#index'
      get 'invoices/:id/customer', to: 'invoices/customers#show'
      get 'invoices/:id/merchant', to: 'invoices/merchants#show'
      resources :invoices, only: [:index, :show]
      # Invoice Items Endpoints
      get 'invoice_items/find', to: 'invoice_items/search#show'
      get 'invoice_items/find_all', to: 'invoice_items/search#index'
      get 'invoice_items/:id/invoice', to: 'invoice_items/invoices#show'
      get 'invoice_items/:id/item', to: 'invoice_items/items#show'
      resources :invoice_items, only: [:index, :show]
      # Items Endpoints
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      get 'items/:id/invoice_items', to: 'items/invoice_items#index'
      get 'items/:id/merchant', to: 'items/merchants#show'
      # Items Business Intelligence
      get 'items/:id/best_day', to: 'items/best_day#show'
      get 'items/most_revenue', to: 'items/revenue#index'
      get 'items/most_items', to: 'items/most_items#index'
      resources :items, only: [:index, :show]

      # Transactions Endpoints
      get 'transactions/find', to: 'transactions/search#show'
      get 'transactions/find_all', to: 'transactions/search#index'
      get 'transactions/:id/invoice', to: 'transactions/invoices#show'
      resources :transactions, only: [:index, :show]

      # Customer Endpoints
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      get 'customers/:id/invoices', to: 'customers/invoices#index'
      get 'customers/:id/transactions', to: 'customers/transactions#index'
      get 'customers/:id/favorite_merchant', to: 'customers/favorite_merchant#show'
      resources :customers, only: [:index, :show]
    end
  end
end
