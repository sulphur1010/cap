class PaypalIpnController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		params.delete(:action)
		params.delete(:controller)
		orig_keys = params.keys
		params = params.delete_if { |p| !PaymentConfirmation.acceptible_fields.include?(p) }
		missing_keys = orig_keys - params.keys
		unless missing_keys.empty?
			Rails.logger.warn "Keys from paypal that are missing in PaymentConfirmation: #{missing_keys.inspect}"
		end
		pc = PaymentConfirmation.create(params)
		unless pc.save
			puts pc.errors
		end

		UserMailer.event_registered_user(pc.event, pc.user).deliver
		render :nothing => true
	end
end
