class Encyclical < ContentFragment
	validates :title, :presence => true
	validates :name, :presence => true
	validates :body, :presence => true

	has_many :encyclical_chapters

	def reference_keyword
		self.title.titleize.gsub(/[^A-Z]/, '')
	end

	def parsed_body
		parse_chapters
	end

	def parse_chapters
		references = EncyclicalReference.where(:encyclical_id => self.id)
		self.chapters.map { |chapter|
			number = chapter.split(".").first
			number = 0 if number.to_i.to_s != number
			ref_count = references.select { |c| c.chapter_number == number.to_i }.count
			ref_count_class = ref_count == 0 ? "encyclical_without_reference" : "encyclical_with_reference"
			ret = "<div id='chapter_#{number}_reference_container' class='chapter_reference_container' style='display: none'></div>"
			ret += "<a class='encyclical_chapter_link #{ref_count_class}' data-id='#{id}' data-chapter='#{number}' data-encyclical='#{reference_keyword}' data-name='chapter_#{number}'></a>"
			ret += "<p class='chapter' id='chapter_#{number}' data-id='#{number}'>#{chapter}</p>"
			ret
		}.join("")
	end

	def self.reference_map
		@reference_map ||= Hash[*Encyclical.all.collect { |c| [c.reference_keyword, c.id] }.flatten]
	end

	def reference_name
		reference_keyword
	end

	def self.chapter_regex
		/<br \/>(?=\d+\. )/
	end

	def chapters
		self.body.split(Encyclical.chapter_regex)
	end

	def self.find_by_reference_keyword(ref)
		@search = Encyclical.search do |q|
			q.with(:reference_name, ref)
		end
		@search.results.first
	end

	def refresh_encyclical_chapters!
		self.encyclical_chapters.map(&:destroy)
		current_chapter = 0
		self.chapters.each do |chapter|
			number = chapter.split(".").first
			number = 0 if number.to_i.to_s != number
			break if number.to_i < current_chapter
			self.encyclical_chapters << EncyclicalChapter.create(:encyclical => self, :chapter_num => number, :chapter_body => chapter)
			current_chapter = number.to_i
		end
	end

end
