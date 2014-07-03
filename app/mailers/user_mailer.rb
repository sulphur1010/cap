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

	def event_registered_admin(event, attendee_event, other)
		@event = event
		@attendee_event = attendee_event
		@payment_method = attendee_event.payment_method
		@other = other
		admins = User.where("role_list like ?", "%admin%").collect { |u| u.email }
		mail(:to => admins, :from => "website-notifications@capp-usa.org", :subject => "Someone registered for a CAPP-USA event!")
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
		@header = sem.header
		@body = sem.body
		@content_fragments = sem.content_fragments
		mail(:to => @to, :from => "website-notifications@capp-usa.org", :subject => @subject, :css => :email)
	end

	def activate_user(user)
		@user = user
		@user.reset_password_token = User.reset_password_token
		@user.reset_password_sent_at = Time.now
		@user.save!
		mail(:to => user.email, :from => "website-notifications@capp-usa.org", :subject => "A CAPP-USA.org Admin has created an account for you")
	end

	def upgrade_contact(contact)
		@contact = contact
		mail(:to => contact.email, :from => "website-notifications@capp-usa.org", :subject => "You are invited to create a CAPP-USA.org Account.")
	end
end
