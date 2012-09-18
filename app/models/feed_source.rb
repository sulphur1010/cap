class FeedSource < ActiveRecord::Base
	validates :url, :presence => true

	after_save :delay_load_channel_data
	attr_accessor :form_save

	has_many :feed_entries, :order => :published_at

	def entries
		feed = Feedzirra::Feed.fetch_and_parse(self.url)
		return [] unless feed
		return feed.entries
	end

	def delay_load_entries
		self.delay.delayed_load_entries
	end

	def delayed_load_entries
		self.entries.each do |e|
			entry = FeedEntry.where(:feed_source_id => self.id).where(:entry_id => e.entry_id).first rescue nil
			if !entry
				entry = FeedEntry.new
				entry.feed_source = self
				entry.entry_id = e.entry_id
				entry.title = e.title
				entry.summary = e.summary
				entry.url = e.url
				entry.published_at = e.published
				entry.save!
				puts "created new entry for feed_source(#{self.id}) with entry_id(#{e.entry_id})"
			end
		end
	end

	private

	def delay_load_channel_data
		self.delay.delayed_load_channel_data if self.form_save == '1'
	end

	def delayed_load_channel_data
		feed = Feedzirra::Feed.fetch_and_parse(self.url)
		if feed
			self.title = feed.title
			#self.description = feed.description
			self.link = feed.url
		else
			self.title = "Error parsing feed data"
		end
		self.save!
	end

end
