class UserMailer < ActionMailer::Base
  default from: "drkwright@capp-usa.org"

	def contact_confirmation(contact)
		@contact = contact
	end
end
