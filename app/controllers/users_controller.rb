class UsersController < ApplicationController

	respond_to :html

	def show
		respond_with(@user = User.find(params[:id]))
	end

	def edit
		@user = current_user
		respond_with(@user)
	end

	def update
		data = params[:user]
		if data[:password] && data[:password].empty?
			data.delete(:password)
			data.delete(:password_confirmation)
		end
		data[:contact_attributes][:email] = data[:email] if data[:contact_attributes]
		@user = User.update(current_user.id, data)
		if !@user.errors.empty? && @user.errors[:email]
			@user.email = @user.email_change[0]
			@user.reload
		end

		if @user.errors.empty?
			sign_in(@user, :bypass => true)
		end

		respond_with(@user, :location => profile_url)
	end

	def activate
	end
end
