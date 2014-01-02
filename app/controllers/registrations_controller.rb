class RegistrationsController < Devise::RegistrationsController


	def new
		super
	end

 	def create
 		super
 		check_user

	end

	def update
		super
	end

	def check_user
		@user = User.find_by_email(params[:user][:email])
		Rails.logger.info "user = #{@user}"
		if @user==nil
			@email = Contact.find_by_email(params[:user][:email])
			Rails.logger.info "correo = #{@email.email}"
 			if !@email.email.empty?	
 				@email.destroy
 			end
 		end
	end
end 