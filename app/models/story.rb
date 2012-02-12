class Story < ContentFragment
	validates :title, :presence => true
	validates :body, :presence => true
end
