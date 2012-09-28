class FeedEntry < ActiveRecord::Base
	belongs_to :feed_source

	TEASER_LENGTH = 500

	def helpers
		ActionController::Base.helpers
	end

	def formatted_published_at
		return unless self.published_at
		self.published_at.strftime("%h %d, %Y %I:%M%P")
	end

	def category
		self.feed_source.category rescue ''
	end

	def teaser
		stripped = helpers.strip_tags(self.summary)
		if stripped.size > TEASER_LENGTH
			return "#{stripped[0..TEASER_LENGTH]} ... <a href='#{self.url}' target='_blank'>Rad More</a>"
		end
		self.summary
	end
end
