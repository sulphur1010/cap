class UsersController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@users = User.order(:last_name))
	end

	def show
		respond_with(@user = User.find(params[:id]))
	end

	def new
		respond_with(@user = User.new)
	end

	def create
		respond_with(@user = User.create(params[:user]), :location => users_url)
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
		respond_with(@user = User.update(params[:id], data), :location => users_url)
	end

	def destroy
		respond_with(@user = User.delete(params[:id]), :location => users_url)
	end
end
