class UserMailer < ActionMailer::Base
  #default from: "drkwright@capp-usa.org"
	layout "email"

	def contact_confirmation(contact)
		@contact = contact
		mail(:to => contact.email, :from => "website-notifications@capp-usa.org", :subject => "CAPP-USA.org Thank you for joining our mailing list!")
	end

	def reminder_email(er, user)
	end

	def event_registered_user(event, attendee_event)
		@event = event
		@attendee_event = attendee_event
		mail(:to => attendee_event.email, :from => "drkwright@capp-usa.org", :subject => "You have registered for a CAPP-USA event!")
	end

	def event_daily_summary(event, attendees_events)
		@event = event
		@attendees_events = attendees_events.sort { |a, b| a.attendee.last_name <=> b.attendee.last_name }
		@director = @event.director
		@program_contact = "drkwright@capp-usa.org"
		cc = nil
		if @director && @director.email != @program_contact
			cc = @director.email
		end
		mail(:to => @program_contact, :from => "drkwright@capp-usa.org", :cc => cc, :subject => "#{@event.title} - Contact List (Daily Summary)")
	end

	def event_reminder_user(event, user)
	end

	def welcome_email(user)
		@user = user
		mail(:to => user.email, :from => "website-notifications@capp-usa.org", :subject => "Thank you for registering to CAPP-USA.org!")
	end

	def bulk_email(sem, to_user)
		@user = sem.user
		@to = to_user
		@subject = sem.subject
		@body = sem.body
		mail(:to => @to, :from => "website-notifications@capp-usa.org", :subject => @subject)
	end
end
