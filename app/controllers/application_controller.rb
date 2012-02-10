class ApplicationController < ActionController::Base
  protect_from_forgery

	private

	def is_admin?(&block)
		puts "is_admin?"
		if block_given?
			yield if current_user && current_user.has_role?("admin")
		else
			unless current_user
				puts "NO CURRENT USER"
			end
			if current_user && current_user.has_role?("admin")
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
			yield if current_user && (current_user.has_role?("user") || current_user.has_role?("speaker") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("user") || current_user.has_role?("speaker") || current_user.has_role?("admin"))
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
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
		end
	end

	def require_admin!
		puts "require_admin"
		unless is_admin?
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
		end
	end

	def require_user!
		unless is_user?
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
		end
	end

	def require_speaker!
		unless is_speaker?
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
		end
	end
end
