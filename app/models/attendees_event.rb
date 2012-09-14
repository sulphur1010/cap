class AttendeesEvent < ActiveRecord::Base
	belongs_to :attendee, :class_name => 'User'
	belongs_to :event

	has_one :payment_confirmation

	scope :payment_confirmed, lambda {
		select('attendees_events.*').joins('INNER JOIN `payment_confirmations` on (`attendees_events`.id = `payment_confirmations`.invoice)').where('`payment_confirmations`.payment_status = \'Completed\'')
	}

	def payment_confirmed?
		return (!self.payment_confirmation.nil?) && self.payment_confirmation.payment_status == 'Completed'
	end
end
