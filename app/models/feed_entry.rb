class FeedEntry < ActiveRecord::Base
	belongs_to :feed_source

	def formatted_published_at
		return unless self.published_at
		self.published_at.strftime("%h %d, %Y %I:%M%P")
	end

	def category
		self.feed_source.category rescue ''
	end
end
