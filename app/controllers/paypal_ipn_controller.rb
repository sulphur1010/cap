class PaypalIpnController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		params.delete(:action)
		params.delete(:controller)
		pc = PaymentConfirmation.create(params)
		unless pc.save
			puts pc.errors
		end

		UserMailer.event_registered_user(pc.event, pc.user).deliver
		render :nothing => true
	end
end
