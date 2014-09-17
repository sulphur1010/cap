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

		pc.attendees_event.first_name = pc.first_name
		pc.attendees_event.last_name = pc.last_name
		pc.attendees_event.email = pc.payer_email
		pc.attendees_event.address = pc.address_street
		pc.attendees_event.city = pc.address_city
		pc.attendees_event.zip = pc.address_zip
		pc.attendees_event.guest_name = session[:guest_name]
		pc.attendees_event.attendee_type = session[:attendee_type]
		session[:guest_name] = nil
		session[:attendee_type] = nil
		pc.attendees_event.save
		unless pc.save
			puts pc.errors
		end

		UserMailer.event_registered_user(pc.event, pc.attendees_event).deliver
		UserMailer.event_registered_admin(pc.event, pc.attendees_event, pc).deliver
		render :nothing => true
	end
end
