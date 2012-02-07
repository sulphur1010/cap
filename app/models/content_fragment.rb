class ContentFragment < ActiveRecord::Base
  belongs_to :user

	alias :author :user

	before_save :set_type
	before_save :set_published_at
	before_save :remove_initial_slash_from_url

  validates :title, :presence => true
  validates :url, :uniqueness => true

	private

	def set_type
		self.type = 'ContentFragment' unless self.type
	end

	def set_published_at
		self.published_at = DateTime.now if self.published? and !self.published_at
		self.published_at = nil if !self.published?
	end

	def remove_initial_slash_from_url
		if self.url && self.url =~ /^\//
			self.url = self.url.sub(/^\//, '')
		end
	end

end
