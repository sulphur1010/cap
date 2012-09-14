class ReminderThread
	@@thread = nil

	def self.ensure_running_thread
		if !@@thread || !@@thread.status
			Rails.logger.info "ReminderThread not running.  starting."
			@@thread = Thread.new {
				loop {
					if !EventReminderJob.enqueued?
						Rails.logger.info "EventReminderJob not queued.  queueing."
						Delayed::Job.enqueue EventReminderJob.new
					end
					sleep(5.minutes)
				}
			}
		end
	end

end
