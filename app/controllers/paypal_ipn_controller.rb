class PaypalIpnController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		params.delete(:action)
		params.delete(:controller)
		orig_keys = params.keys
		params.delete_if { |k, v| !PaymentConfirmation.acceptible_fields.include?(k.to_sym) }
		missing_keys = orig_keys - params.keys
		unless missing_keys.empty?
			Rails.logger.warn "Keys from paypal that are missing in PaymentConfirmation: #{missing_keys.inspect}"
		end
		invoice = params[:invoice]
		pc = PaymentConfirmation.update(invoice, params)
		unless pc.save
			puts pc.errors
		end

		UserMailer.event_registered_user(pc.event, pc.attendees_event).deliver
		render :nothing => true
	end
end
