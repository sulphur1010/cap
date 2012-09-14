class PaypalIpnController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		params.delete(:action)
		params.delete(:controller)
		pc = PaymentConfirmation.create(params)
		unless pc.save
			puts pc.errors
		end
		render :nothing => true
	end
end
