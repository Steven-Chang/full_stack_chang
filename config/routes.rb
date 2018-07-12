Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'application#index'

  resources :tranxactions
  resources :tranxaction_types
  resources :properties do
    resources :tenancy_agreements
  end
  resources :tenancy_agreements
  resources :creditors
  resources :client_payments

  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  resources :cleaning_records, only: [:index, :create, :destroy]
  resources :cleaning_tasks, only: [:index, :create, :destroy]
  resources :clients
  resources :farming_transactions, except: [:show]
  resources :jobs
  resources :projects, only: [:index, :create]
  resources :scores, only: [:index, :create]
  resources :blog_posts, only: [:index, :create, :destroy]
  resources :rent_transactions, except: [:show]
  resources :users, only: [:index]

  get 'users/:user_id/bond' => 'users#bond'
  get 'users/:user_id/balance' => 'users#balance'
  get 'number_of_users' => 'users#return_number_of_users'
  put 'users/:user_id' => 'users#update_other_params'
  get 'tenants' => 'users#tenants'

 # Need this for prettifying url
  get '/', :to => redirect('/#!/')

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
