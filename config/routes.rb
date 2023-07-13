Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show, :search] do
        resources :items, only: [:index], controller: :merchant_items
        # resources :find, only: [:find], controller: :merchants_search
        collection do
          get '/find', to: 'merchants#search'
        end
      end
      resources :items, only: [:index, :show, :create, :update, :delete, :destroy] do
        resources :merchant, only: [:index], controller: :items_merchant
        collection do
          get '/find_all', to: 'items#search'
        end
        # resources :search, only: [:search], controller: :items_search
      end
    end
  end
end
