class ContactsController < ApplicationController

	respond_to :html

	def create

		# trap some bots!
		if params[:contact][:first_name] != "" || params[:contact][:last_name] != " "
			flash[:notice] = "bot trap!!"
			redirect_to(:back)
			return
		end

		params[:contact].delete(:first_name)
		params[:contact].delete(:last_name)

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
