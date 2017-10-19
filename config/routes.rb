Rails.application.routes.draw do

  root "static_pages#home"

  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact"
  get "/products_manager", to: "static_pages#products_manager"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :products do
    resources :parameters, except: %i(index show)
  end
  resources :categories
  resources :comments, only: %i(create destroy)
  resource :cart, only: [:show]
  resources :order_details, only: %i(create update destroy)
  resources :checkouts, only: %i(index create)
  resources :my_orders, only: [:index]
  resources :orders, only: %i(show update)
end
