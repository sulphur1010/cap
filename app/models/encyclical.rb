class Encyclical < ContentFragment
	validates :title, :presence => true
	validates :name, :presence => true
	validates :body, :presence => true

	def reference_keyword
		self.title.titleize.gsub(/[^A-Z]/, '')
	end

	def parsed_body
		parse_chapters
	end

	def parse_chapters
		self.body.split(/<br \/>(?=\d+\. )/).map {|chapter|
			number = chapter.split(".").first
			number = 0 if number.to_i.to_s != number
			"<a name='chapter_#{number}'></a><p class='chapter' id='chapter_#{number}' data-id='#{number}'>#{chapter}</p>"
		}.join("")
	end

	def self.reference_map
		@reference_map ||= Hash[*Encyclical.all.collect { |c| [c.reference_keyword, c.id] }.flatten]
	end

end
