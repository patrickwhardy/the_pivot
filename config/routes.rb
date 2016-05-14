Rails.application.routes.draw do
  root to: 'homes#index'
  post "/", to: "homes#index"

  namespace :admin do
    resources :homes, only: [:index]
    patch "/homes/:id/suspend", to: "homes#suspend", as: :suspend_home
    patch "/homes/:id/reactivate", to: "homes#reactivate", as: :reactivate_home
    resources :owners, only: [:index]
    resources :users, only: [:index]
  end

  namespace :user, path: ":path", as: :user do
    resources :homes, only: [:create, :new, :edit, :update, :index, :show]
  end

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create", as: :session_users
  get "/cart/login", to: "sessions#new", as: :cart_login

  resources :orders, only: [:index, :create, :show]

  resources :tools, only: [:index, :show]
  # post "/tools/:id", to: "cart_tools#create"
  post ":user/homes/:id", to: "cart_homes#create"

  resources :users, only: [:new, :index, :edit, :create, :update, :destroy]

  get "/:user/dashboard", to: "users#show", as: :dashboard
  delete "/users/logout", to: "sessions#destroy", as: :logout
  resources :cart_tools, only: [:create, :destroy]
  resource :cart, only: [:show, :update]

  get "/search", to: "homes#search", as: :search
  get "/:category_name", to: 'categories#view', as: :category_name
end
