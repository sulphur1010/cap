class UserMailer < ActionMailer::Base
  default from: "drkwright@capp-usa.org"

	def contact_confirmation(contact)
		@contact = contact
	end

	def reminder_email(er, user)
	end
end
