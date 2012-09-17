class UserMailer < ActionMailer::Base
  default from: "drkwright@capp-usa.org"

	def contact_confirmation(contact)
		@contact = contact
	end

	def reminder_email(er, user)
	end

	def event_registered_user(event, user)
		@event = event
		@user = user
		mail(:to => user.email, :subject => "You have registered for a CAPP-USA event!")
	end

	def event_daily_summary(event, users)
		@event = event
		@users = users
		@director = @event.director
		@program_contact = "drkwright@capp-usa.org"
		cc = nil
		if @director && @director.email != @program_contact
			cc = @director.email
		end
		mail(:to => @program_contact, :cc => cc, :subject => "#{@event.title} - Contact List (Daily Summary)")
	end

	def event_reminder_user(event, user)
	end
end
