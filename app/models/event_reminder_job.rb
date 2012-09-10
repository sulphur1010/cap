class EventReminderJob

	def perform
		processed_events = []
		EventReminder.unsent.order('event_id asc, duration asc').each do |er|
			if er.send_now? && !processed_events.include?(er.event_id)
				er.send!
				er.earlier_reminders.map(&:mark_sent!)
				processed_events << er.event_id
			end
		end
	end

end

