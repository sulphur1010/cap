class Encyclical < ContentFragment
	validates :title, :presence => true
	validates :name, :presence => true
	validates :body, :presence => true

	def reference_keyword
		self.title.titleize.gsub(/[^A-Z]/, '')
	end

end
