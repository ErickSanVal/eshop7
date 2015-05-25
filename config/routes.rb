Rails.application.routes.draw do
  namespace :admin do
  get 'order/index'
  end

  namespace :admin do
  get 'order/show'
  end

  namespace :admin do
  get 'order/close'
  end

  get 'checkout/index'

  get 'checkout/place_order'

  get 'checkout/thank_you'

  get 'checkout' => 'checkout#index'

  post 'checkout/submit_order'
  get 'checkout/thank_you'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  get 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'

  get 'user_sessions/new'
  get 'user_sessions/create' # for showing failed login screen after restarting web server
  post 'user_sessions/create'
  get 'user_sessions/destroy'

  root :to => 'catalog#index'

  get 'cart/add'
  post 'cart/add'

  get 'cart/remove'
  post 'cart/remove'

  get 'cart/clear'
  post 'cart/clear'

  get 'catalog/index'

  get 'catalog/search'

  get 'catalog/show'

  get 'catalog/latest'

  namespace :admin do
  get 'tshirt/new'
  end

  namespace :admin do
  post 'tshirt/create'
  end

  namespace :admin do
  get 'tshirt/edit'
  end

  namespace :admin do
  post 'tshirt/update'
  end

  namespace :admin do
  post 'tshirt/destroy'
  end

  namespace :admin do
  get 'tshirt/show'
  end

  namespace :admin do
  get 'tshirt/index'
  end

  namespace :admin do
  get 'manufacturer/new'
  end

  namespace :admin do
  post 'manufacturer/create'
  end

  namespace :admin do
  get 'manufacturer/edit'
  end

  namespace :admin do
  post 'manufacturer/update'
  end

  namespace :admin do
  post 'manufacturer/destroy'
  end

  namespace :admin do
  get 'manufacturer/show'
  end

  namespace :admin do
  get 'manufacturer/index'
  end

  get 'about/index'

  post 'admin/order/close'
  post 'admin/order/destroy'
  get 'admin/order/show'
  get 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'


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
