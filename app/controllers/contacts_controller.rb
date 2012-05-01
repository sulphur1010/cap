class ContactsController < ApplicationController

	respond_to :html

	def create
		thanks_message = "Thanks for your information.  We'll be in touch!"
		search = Contact.find_by_email(params[:contact][:email])
		if search == nil
			@contact = Contact.create(params[:contact])
			if !@contact.errors.empty?
				flash[:alert] = "Error saving information.  #{@contact.errors.full_messages.to_sentence}."
			else
				flash[:notice] = thanks_message
			end
		else
			flash[:notice] = thanks_message
		end
		redirect_to(:back)
	end
end
