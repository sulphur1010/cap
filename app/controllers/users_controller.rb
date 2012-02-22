class UsersController < ApplicationController

	respond_to :html

	def show
		respond_with(@user = User.find(params[:id]))
	end
end
