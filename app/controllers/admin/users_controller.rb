class Admin::UsersController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@users = User.order(:last_name))
	end

	def search
		@q = params[:q]
		if @q.empty?
			@users = User.order(:last_name)
			render :action => :index
			return
		end
		users = User.arel_table
		@users = User.where(users[:first_name].matches("%#{@q}%")).all
		@users += User.where(users[:last_name].matches("%#{@q}%")).all
		@users += User.where(users[:email].matches("%#{@q}%")).all
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
		respond_with(@user = User.find(params[:id]))
	end

	def update
		data = params[:user]
		if data[:password] && data[:password].empty?
			data.delete(:password)
			data.delete(:password_confirmation)
		end
		respond_with(@user = User.update(params[:id], data), :location => admin_users_url)
	end

	def destroy
		respond_with(@user = User.delete(params[:id]), :location => admin_users_url)
	end
end
