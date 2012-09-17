class EventRegistrationJob

	def self.next_run
		# 17 = 5pm
		next_time = Date.today.to_time + 17.hours
		if Time.now > next_time
			next_time += 1.day
		end
		next_time
	end

	def perform
		processed_events = []
		Event.upcoming.each do |event|
			users = event.aggregate_attendees_list(1.day)
			if !users.empty?
				UserMail.event_daily_summary(event, users).deliver
			end
		end
	end
	handle_asynchronously :perform, :run_at => Proc.new { next_run }

	def self.enqueued?
		!Delayed::Job.all.select { |j| YAML.load(j.handler).class == self }.empty?
	end

end

