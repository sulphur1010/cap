class Page < ContentFragment
  validates :url, :presence => true, :uniqueness => true

	before_save :add_initial_slash_from_url

  private

	def add_initial_slash_from_url
    self.url = "/#{self.url}" if self.url[0..0] != "/"
	end
end
