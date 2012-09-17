class EventRegistrationThread
	@@thread = nil

	def self.ensure_running_thread
		if !@@thread || !@@thread.status
			Rails.logger.info "EventRegistrationThread not running.  starting."
			@@thread = Thread.new {
				loop {
					if !EventRegistrationJob.enqueued?
						Rails.logger.info "EventRegistrationJob not queued.  queueing."
						Delayed::Job.enqueue(EventRegistrationJob.new, { :run_at => EventRegistrationJob.next_run })
					end
					sleep(15.minutes)
				}
			}
		end
	end

end
