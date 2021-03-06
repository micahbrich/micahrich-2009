ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  map.archive '/blog/archive', :controller => 'posts', :action => 'archive'
  map.feed '/blog/feed', :controller => 'posts', :action => 'feed'
  map.feed '/blog/imagefeed', :controller => 'posts', :action => 'image_feed'
  map.feed '/blog/imagefeed.:format', :controller => 'posts', :action => 'image_feed'
  map.feed '/blog/feed.:format', :controller => 'posts', :action => 'feed'
  map.about '/blog/about', :controller => 'posts', :action => 'about'
  
  map.gettr '/blog/gettr', :controller => 'posts', :action => 'gettr'
  map.resources :posts, :collection => { :feed => :get, :archive => :get, :gettr => :put }, :has_many => :comments, :as => 'blog'
  map.resources :posts, :collection => { :feed => :get, :archive => :get, :gettr => :put }, :has_many => :comments, :as => 'blog/posts'
  
  map.resources :sessions
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.blog_root '/blog', :controller => "posts"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
