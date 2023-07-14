Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], to: 'merchants/items#index'
        collection do
          get '/find', to: 'merchants/search#search'
        end
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], to: 'items/merchant#index'
        collection do
          get '/find_all', to: 'items/search#search'
        end
      end
    end
  end
end
