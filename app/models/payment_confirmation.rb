class PaymentConfirmation < ActiveRecord::Base
	before_create :parse_event_and_user

	private

	def parse_event_and_user
		data = self.invoice.split("-")
		self.event_id = data.first
		self.user_id = data.last

		ae = AttendeesEvent.where(:attendee_id => data.last).where(:event_id => data.first).first rescue nil

		if !ae
			ae = AttendeesEvent.new
			ae.attendee_id = data.last
			ae.event_id = data.first
			ae.save!
		end
	end
end
