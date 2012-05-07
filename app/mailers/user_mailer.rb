class UserMailer < ActionMailer::Base
  default from: "website@capp-usa.org"

	def contact_confirmation(contact)
		@contact = contact
	end
end
