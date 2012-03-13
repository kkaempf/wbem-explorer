WbemExplorer::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
  get 'home' => 'home#index'
  get 'intro' => 'intro#index'
  get 'about' => 'about#index'

  get 'status/update' => 'status#update'
  get 'status/connected' => 'status#connected'

  resources :namespaces, :only => [:index, :show]
  resources :systems, :only => [:index, :show]
  resources :services, :only => [:index, :show]
  resources :processes, :only => [:index, :show]
  resources :networks, :only => [:index, :show]
  resources :storages, :only => [:index, :show]
  resources :models, :only => [:index, :show]
  get 'classnames/data' => 'classnames#data' # Ajax callback
  resources :classnames, :only => [:index, :show]
  get 'cim_classes/data' => 'cim_classes#data' # Ajax callback
  resources :cim_classes, :only => [:index, :show]
  resources :instances

  get 'search_host' => 'hosts#search'
  resources :hosts
  get 'search_user' => 'users#search'
  resources :users
  get 'search_connection' => 'connections#search'
  get 'disconnect' => 'connections#disconnect'
  resources :connections do
    get 'connect' => 'connections#connect'
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #  match ':controller(/:action(/:id(.:format)))'
end
