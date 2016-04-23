Rails.application.routes.draw do
  root to: 'tools#index'
  namespace :admin do
    get "/dashboard", to: "users#show"
    get "/tools/new", to: "tools#new"
    post "/tools", to: "tools#create"
  end
  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create", as: :session_users
  get "/cart/login", to: "sessions#cart_login", as: :cart_login
  get "/orders", to: "orders#index", as: :orders_index
  post "/orders", to: "orders#create", as: :orders
  get "/orders/:id", to: "orders#show"

  resources :tools, only: [:index, :show]

  resources :users, only: [:new, :index, :create]
  get "/users/:id", to: "users#show", as: :dashboard
  delete "/users/logout", to: "sessions#destroy", as: :logout


  get "/cart", to: "carts#show"
  post "/cart", to: "cart_tools#update"
  get "/:category_name", to: 'categories#view', as: :category_name

  resources :cart_tools, only: [:create, :destroy]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
