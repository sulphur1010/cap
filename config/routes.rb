CappUsa::Application.routes.draw do
	devise_for :users, :path_names => { :sign_in => 'login' }

	resources :mail
	resources :contact_lists do
		collection do
			get :by_type
		end
	end
	resources :static_contact_lists

	namespace :admin do
		resources :blocks
		resources :chapters
		resources :contemporary_issues
		resources :encyclicals
		resources :events do
			member do
				get 'user_list'
			end

			resources :attendees_events
		end
		resources :locations
		resources :menu_items
		resources :pages
		resources :person_types
		resources :principles
		resources :papal_addresses
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
	resources :encyclicals, :path => "social_encyclicals" do
		collection do
			get 'published'
			get 'popup'
			get 'search'
			post 'search'
		end
		member do
			get 'reference'
		end
	end
	resources :events do
		member do
			post 'rsvp'
			post 'unrsvp'
			get 'thanks'
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
	resources :stories, :path => "news"
	resources :papal_addresses
	resources :feed_entries
	resources :thoughts, :path => "social_thought"
	resources :contacts
	resources :users

	match 'what_is_cst' => 'home#what_is_cst'
	match 'study_center' => 'home#study_center'
	match 'about_us/capp_usa_team' => 'home#about_us_capp_usa_team'
	match 'search' => 'search#index'
	match 'encyclicals/:id/chapter/:chapter/references' => 'encyclicals#chapter_references'
	match 'encyclicals/popup' => 'encyclicals#popup'

	post 'paypal_ipn', :to => 'paypal_ipn#index', :as => 'paypal_ipn'

	match '*url' => 'pages#view'

	root :to => 'home#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
