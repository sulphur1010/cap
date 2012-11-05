class ChapterPresidentContactList < ContactList
	def contacts
		User.chapter_presidents
	end
end
