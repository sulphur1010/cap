class EventReminder < ActiveRecord::Base
	belongs_to :event

	attr_accessible :duration, :sent, :sent_at, :event_id

	scope :unsent, where(:sent => false)
	scope :sent, where(:sent => true)
	scope :for_event, lambda { |e| where(:event_id => e.id) }
	scope :longer_than, lambda { |d| where(['duration > ?', d.to_i]) }

	def earlier_reminders
		EventReminder.for_event(self.event).longer_than(self.duration)
	end

	def send_now?
		((DateTime.now + self.duration.seconds > self.event.start_date) and (DateTime.now < self.event.start_date)) rescue false
	end

	def send_at
		self.event.start_date - self.duration.seconds
	end

	def send!
		logger.info "EventReminder/#{self.id}::send!"
		self.event.attendees.each do |user|
			UserMailer.reminder_email(self, user).deliver
		end
		self.mark_sent!
	end

	def mark_sent
		logger.info "EventReminder/#{self.id}::mark_sent"
		self.sent = true
		self.sent_at = DateTime.now
	end

	def mark_sent!
		self.mark_sent
		self.save!
	end


end
