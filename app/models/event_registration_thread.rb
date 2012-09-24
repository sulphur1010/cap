class EventRegistrationThread
	@@event_registration_thread = nil

	def self.ensure_running_thread
		if !@@event_registration_thread || !@@event_registration_thread.status
			Rails.logger.info "EventRegistrationThread not running.  starting."
			@@event_registration_thread = Thread.new {
				loop {
					if !EventRegistrationJob.enqueued?
						Rails.logger.info "EventRegistrationJob not queued.  queueing."
						Delayed::Job.enqueue(EventRegistrationJob.new, { :run_at => EventRegistrationJob.next_run })
					end
					sleep(1.hour.to_i)
				}
			}
		end
	end

end
