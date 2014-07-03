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

		pc.attendee_event.first_name = pc.first_name
		pc.attendee_event.last_name = pc.last_name
		pc.attendee_event.email = pc.payer_email
		pc.attendee_event.address = pc.address_street
		pc.attendee_event.city = pc.address_city
		pc.attendee_event.zip = pc.address_zip
		pc.attendee_event.guest_name = session[:guest_name]
		session[:guest_name] = nil
		pc.attendee_event.save
		unless pc.save
			puts pc.errors
		end

		UserMailer.event_registered_user(pc.event, pc.attendees_event).deliver
		UserMailer.event_registered_admin(pc.event, pc.attendee_event, pc).deliver
		render :nothing => true
	end
end
