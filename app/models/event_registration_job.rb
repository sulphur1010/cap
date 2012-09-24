class EventRegistrationJob
	include ScheduledJob

	run_every 1.minute

	# we do this so this runs every day exactly at 5pm
	# this gets rescheduled *after* the job is done
	def self.next_run
		puts "EventRegistrationJob::next_run - calculating next run time"
		# 17 = 5pm
		next_time = Date.today.to_time + 17.hours
		if Time.now > next_time
			next_time += 1.day
		end
		next_time
	end

	def self.run_at
		EventRegistrationJob.next_run
	end

	def perform
		puts "EventRegistrationJob::perform"
		processed_events = []
		Event.upcoming.each do |event|
			users = event.aggregate_attendees_list(1.day)
			puts "EventRegistrationJob::perform - event = #{event.id.to_s}, users = #{users.count}"
			if !users.empty?
				puts "EventRegistrationJob::perform - sending an email!"
				UserMailer.event_daily_summary(event, users).deliver
			end
		end
	end

	def self.enqueued?
		!Delayed::Job.all.select { |j| YAML.load(j.handler).class == self }.empty?
	end
end

