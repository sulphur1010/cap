class AttendeesEvent < ActiveRecord::Base
	belongs_to :attendee, :class_name => 'User'
	belongs_to :event

	has_one :payment_confirmation

	scope :payment_confirmed, lambda {
		select('attendees_events.*').joins('INNER JOIN `payment_confirmations` on (`attendees_events`.id = `payment_confirmations`.invoice)').where('`payment_confirmations`.payment_status = \'Completed\'')
	}

	validates :first_name, :presence => true, :if => :local_fields?
	validates :last_name, :presence => true, :if => :local_fields?
	validates :email, :presence => true, :if => :local_fields?

	def payment_confirmed?
		return (!self.payment_confirmation.nil?) && self.payment_confirmation.payment_status == 'Completed'
	end

	def first_name
		return self.attendee.first_name if self.attendee && self.attendee.first_name
		return self.payment_confirmation.first_name if self.payment_confirmation && self.payment_confirmation.first_name
		return self.read_attribute(:first_name) if local_fields?
		""
	end

	def last_name
		return self.attendee.last_name if self.attendee && self.attendee.last_name
		return self.payment_confirmation.last_name if self.payment_confirmation && self.payment_confirmation.last_name
		return self.read_attribute(:last_name) if local_fields?
		""
	end

	def email
		return self.attendee.email if self.attendee && self.attendee.email
		return self.payment_confirmation.payer_email if self.payment_confirmation && self.payment_confirmation.payer_email
		return self.read_attribute(:email) if local_fields?
		""
	end

	def count
		cnt = read_attribute(:count)
		if self.payment_confirmation
			cnt = self.payment_confirmation.quantity1
		end
		return 1 unless cnt
		return 1 if cnt == 0
		cnt
	end

	def total_cost
		cnt = read_attribute(:total_cost)
		if self.payment_confirmation
			cnt = self.payment_confirmation.payment_gross
		end
		return 0 unless cnt
		cnt
	end

	def created_at
		ca = read_attribute(:created_at)
		ca = (Time.new - 5.years) unless ca
		return ca
	end

	def payment_method
		return "other" unless self.payment_confirmation
		"paypal"
	end

	def local_fields?
		payment_method == "other" && self.attendee.nil?
	end
end
