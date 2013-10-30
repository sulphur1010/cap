class Admin::UsersController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@users = User.by_last_name)
	end

	def search
		@q = params[:q]
		if @q.empty?
			@users = User.order(:last_name)
			render :action => :index
			return
		end
		users = User.arel_table
		#@users = User.where(users[:first_name].matches("%#{@q}%")).all
		#@users += User.where(users[:last_name].matches("%#{@q}%")).all
		@users = User.where(users[:email].matches("%#{@q}%")).all
		@users += User.where(users[:role_list].matches("%#{@q}%")).all
		@users = @users.flatten.compact.uniq.sort_by(&:last_name)
		render :action => :index
	end

	def show
		respond_with(@user = User.find(params[:id]))
	end

	def new
		respond_with(@user = User.new)
	end

	def create
		respond_with(@user = User.create(params[:user]), :location => admin_users_url)
	end

	def edit
		session[:return_url] = params[:return_url] if params[:return_url]
		respond_with(@user = User.find(params[:id]))
	end

	def update
		location = admin_users_url
		if session[:return_url]
			location = session[:return_url]
			session.delete(:return_url)
		end
		data = params[:user]
		if data[:password] && data[:password].empty?
			data.delete(:password)
			data.delete(:password_confirmation)
		end
		data[:contact_attributes][:email] = data[:email] if data[:contact_attributes]
		@user = User.update(params[:id], data)
		if !@user.errors.empty? && @user.errors[:email]
			@user.email = @user.email_change[0]
			@user.reload
		end

		if @user.errors.empty? && current_user == @user
			sign_in(@user, :bypass => true)
		end

		respond_with(@user, :location => location)
	end

	def activate
		@user = User.find(params[:id])
		UserMailer.activate_user(@user).deliver
		redirect_to admin_user_url(@user)
	end

	def destroy
		respond_with(@user = User.delete(params[:id]), :location => admin_users_url)
	end
end
