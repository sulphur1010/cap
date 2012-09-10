class FeedEntry < ActiveRecord::Base
	belongs_to :feed_source

	def formatted_published_at
		return unless self.published_at
		self.published_at.strftime("%h %d, %Y %H:%M%P")
	end
end
