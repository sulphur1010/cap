class Story < ContentFragment
	def self.categories
		["All", "International", "USA", "Vatican", "CAPP"]
	end

	validates :title, :presence => true
	validates :body, :presence => true
	validates :category, :inclusion => { :in => Story.categories }

end
