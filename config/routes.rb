Rails.application.routes.draw do
  root to: 'tools#index'

  namespace :admin do
    get "/dashboard", to: "users#show"
    resources :tools, only: [:create, :new, :edit, :update, :index]
  end

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create", as: :session_users
  get "/cart/login", to: "sessions#new", as: :cart_login

  resources :orders, only: [:index, :create, :show]

  resources :tools, only: [:index, :show]
  post "/tools/:id", to: "cart_tools#create"

  resources :users, only: [:new, :index, :create, :edit, :update]

  get "/users/:id", to: "users#show", as: :dashboard
  delete "/users/logout", to: "sessions#destroy", as: :logout
  resources :cart_tools, only: [:create, :destroy]
  resource :cart, only: [:show, :update]

  get "/:category_name", to: 'categories#view', as: :category_name
end
