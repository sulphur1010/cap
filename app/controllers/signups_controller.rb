class SignupsController < ApplicationController

	def index
		@signup = Signup.new
	end

	def create
		@signup = Signup.new(params[:signup])
		success, id = Signup.payment(params[:credit_card], @signup)
		if success
			@signup.paypal_id = id
			@signup.save
			UserMailer.signup_confirm(@signup).deliver
			UserMailer.signup_user_confirm(@signup).deliver
			redirect_to confirm_signups_path 
		else
			render :text => "something went wrong: #{id.to_s}"
		end
	end
end
