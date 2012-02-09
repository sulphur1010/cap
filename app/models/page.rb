class Page < ContentFragment
	validates :title, :presence => true
  validates :url, :presence => true, :uniqueness => true
	validates :body, :presence => true

	before_save :add_initial_slash_from_url

  private

	def add_initial_slash_from_url
    self.url = "/#{self.url}" unless self.url =~ /^\//
	end
end
