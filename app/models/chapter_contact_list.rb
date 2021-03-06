class ChapterContactList < ContactList

	attr_accessor :chapter

	def contacts
		return [] unless self.chapter
		self.chapter.users
	end

	def display_name
		"Chapter - #{self.chapter.name}" if self.chapter
	end
end
