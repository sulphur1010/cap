class FeedUpdateThread
	@@feed_update_thread = nil

	def self.ensure_running_thread
		if !@@feed_update_thread || !@@feed_update_thread.status
			Rails.logger.info "FeedUpdateThread not running.  starting."
			@@feed_update_thread = Thread.new {
				loop {
					if !FeedUpdateJob.enqueued?
						Rails.logger.info "FeedUpdateJob not queued.  queueing."
						Delayed::Job.enqueue(FeedUpdateJob.new)
					end
					sleep(1.hour)
				}
			}
		end
	end

end
