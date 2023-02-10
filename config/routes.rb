Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/v1/merchants/find", to: "api/v1/merchants/search#show"
  get "/api/v1/items/find_all", to: "api/v1/items/search#show"

  namespace :api do
    namespace :v1 do
      resources :items do
        resources :merchant, only: [:index], controller: "items_merchants"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchants/items"
      end
    end
  end

end
