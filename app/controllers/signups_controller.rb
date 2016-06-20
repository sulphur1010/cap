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
			raise "Something went wrong"
		end
	end
	
	def confirm
	end
	
	def error
		@hash = JSON.parse(@signup.paypal_id)
		if @hash[:name] == "CREDIT_CARD_REFUSED"
			@error = "Your credit card was declined. Please check the details you entered and try again. We apologize for the inconvenience."
		else
			@error = "An unknown error occured while attempting to process your credit card. Please check the details you entered and try again. We apologize for the inconvenience."
		end
	end
end
