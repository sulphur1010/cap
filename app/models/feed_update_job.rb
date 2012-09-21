class FeedUpdateJob
	include ScheduledJob

	run_every 1.day

	def self.next_run
		1.day.from_now
	end

	def perform
		puts "FeedUpdateJob::perform"
		FeedSource.all.each do |feed_source|
			feed_source.delay_load_entries
		end
	end

	def self.enqueued?
		!Delayed::Job.all.select { |j| YAML.load(j.handler).class == self }.empty?
	end
end

