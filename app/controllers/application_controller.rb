class ApplicationController < ActionController::Base
  protect_from_forgery

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
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
		end
	end
end
