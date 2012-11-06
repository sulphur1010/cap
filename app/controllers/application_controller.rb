class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :ensure_running_threads
	before_filter :setup_variables

	private

	def after_sign_in_path_for(resource)
		session[:return_url] || "/"
	end

	def setup_variables
		@show_right_side_bar = true
	end

	def ensure_running_threads
		ReminderThread.ensure_running_thread
		EventRegistrationThread.ensure_running_thread
		FeedUpdateThread.ensure_running_thread
	end

	def paypal_url(event, id, cost, text='')
		title = event.title
		if text != ''
			title = "#{title} (#{text})"
		end
		values = {
			:business => Rails.env.production? ? 'payments@capp-usa.org' : 'seller_1316980320_biz@darmasoft.com',
			:cmd => '_cart',
			:upload => 1,
			:return => event_url(event, :thanks => '1'),
			:invoice => id,
			:notify_url => paypal_ipn_url,
			"item_number_1" => id
		}
		url = "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
		if !Rails.env.production?
			url = "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
		end
		url
	end

	def is_admin?(&block)
		if block_given?
			yield if current_user && current_user.has_role?("admin")
		else
			if current_user && current_user.has_role?("admin")
				return true
			else
				return false
			end
		end
	end

	def is_thought_creator?(&block)
		if block_given?
			yield if current_user && (current_user.has_role?("thought_creator") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("thought_creator") || current_user.has_role?("admin"))
				return true
			else
				return false
			end
		end
	end

	def is_speaker?(&block)
		if block_given?
			yield if current_user && (current_user.has_role?("speaker") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("speaker") || current_user.has_role?("admin"))
				return true
			else
				return false
			end
		end
	end


	def is_user?(&block)
		if block_given?
			yield if current_user && (current_user.has_role?("user") || current_user.has_role?("speaker") || current_user.has_role?("thought_creator") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("user") || current_user.has_role?("speaker") || current_user.has_role?("thought_creator") || current_user.has_role?("admin"))
				return true
			else
				return false
			end
		end
	end

	def has_role?(r, &block)
		if block_given?
			yield if current_user && current_user.has_role?(r)
		else
			if current_user && current_user.has_role?(r)
				return true
			else
				return false
			end
		end
	end

	def check_role?(r)
		unless current_user && current_user.has_role?(r)
			not_found
		end
	end

	def require_admin!
		unless is_admin?
			not_found
		end
	end

	def require_user!
		unless is_user?
			not_found
		end
	end

	def require_thought_creator!
		unless is_thought_creator?
			not_found
		end
	end

	def require_speaker!
		unless is_speaker?
			not_found
		end
	end

	def not_found
		render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
	end

	def load_contact_lists
		@contact_lists = ContactList.all_contact_lists
	end
end
