Rails.application.routes.draw do
  # get 'users/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :dashboards, only: :index

  get 'pages/about_us'
  get 'pages/contact_us'


  resources :agents do
    member do
      get 'my_patients'

      get 'my_colleagues'
      get 'all_agents'
      get 'patients_by_agent'
      get 'my_profile'
      get 'add_agent'

      get 'add_agent'
      post 'create_agent'

    end
    collection do
      post 'update_agent'
      post 'my_patients_sort'
      post 'search_patient'
    end
  end

  resources :managers do
    member do
      post 'approve_reject_agent'

    end
    collection do
      get 'my_agents'
      post 'filter_agent'
    end
  end

  resources :patients
  root 'dashboards#index'
  get '*path' => redirect('/')


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

 # root 'passthrough#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #    member do
  #       get 'short'
  #       post 'toggle'
  #     end

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
