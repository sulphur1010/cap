CappUsa::Application.routes.draw do
	devise_for :users

	namespace :admin do
		resources :blocks
		resources :chapters
		resources :contemporary_issues
		resources :encyclicals
		resources :events
		resources :locations
		resources :menu_items
		resources :pages
		resources :person_types
		resources :principles
		resources :prism_types
		resources :role_types
		resources :stories
		resources :thoughts
		resources :feed_sources
		resources :users do
			collection do
				post 'search'
			end
		end
		resources :questions
		resources :content_fragments do
			collection do
				get 'type_options/:content_fragment_type', :action => 'type_options'
			end
		end
		resources :contacts do
			collection do
				get 'raw'
			end
		end
	end

	resources :contemporary_issues do
		member do
			get 'view'
		end
	end
	resources :encyclicals do
		collection do
			get 'published'
		end
	end
	resources :events do
		member do
			post 'rsvp'
			get 'rsvp'
			post 'unrsvp'
		end
		collection do
			get 'past'
		end
	end
	resources :locations
	resources :person_types
	resources :principles
	resources :prism_types
	resources :role_types
	resources :stories
	resources :thoughts
	resources :contacts
	resources :users

	match 'what_is_cst' => 'home#what_is_cst'
	match 'study_center' => 'home#study_center'
	match 'about_us/team' => 'home#about_us_team'
	match 'search' => 'search#index'

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
	match '*url' => 'pages#view'

	# Sample resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
	

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	root :to => 'home#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
