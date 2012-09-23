class EventReminderJob
	include ScheduledJob

	run_every 5.minutes

	def self.next_run
		5.minutes.from_now
	end

	def perform
		puts "EventReminderJob::perform"
		processed_events = []
		EventReminder.unsent.order('event_id asc, duration asc').each do |er|
			if er.send_now? && !processed_events.include?(er.event_id)
				er.send!
				er.earlier_reminders.map(&:mark_sent!)
				processed_events << er.event_id
			end
		end
		Delayed::Job.all.each { |c| YAML.load(c.handler).class == self ? c.destroy : '' }
	end

	def self.enqueued?
		!Delayed::Job.all.select { |j| YAML.load(j.handler).class == self }.empty?
	end
end

