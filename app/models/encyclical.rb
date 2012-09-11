class Encyclical < ContentFragment
	validates :title, :presence => true
	validates :name, :presence => true
	validates :body, :presence => true

	before_save :parse_chapters

	def reference_keyword
		self.title.titleize.gsub(/[^A-Z]/, '')
	end

	def parse_chapters
		self.body.split(/<br \/>(?=\d+\. )/).map {|chapter|
			number = chapter.split(".").first
			number = 0 if number.to_i.to_s != number
			"<a name='chapter_#{number}'></a><p class='chapter' id='chapter_#{number}' data-id='#{number}'>#{chapter}</p>"
		}.join("")
	end

end
