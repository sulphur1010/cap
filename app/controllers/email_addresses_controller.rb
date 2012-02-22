class EmailAddressesController < ApplicationController

	respond_to :html

	def create
		thanks_message = "Thanks for your email address.  We'll be in touch!"
		search = EmailAddress.find_by_email(params[:email_address][:email])
		if search == nil
			@email_address = EmailAddress.create(params[:email_address])
			if !@email_address.errors.empty?
				flash[:alert] = "Error saving email address.  #{@email_address.errors.full_messages.to_sentence}."
			else
				flash[:notice] = thanks_message
			end
		else
			flash[:notice] = thanks_message
		end
		redirect_to(:back)
	end
end
