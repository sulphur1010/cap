class ThoughtCreatorContactList < ContactList
	def contacts
		User.thought_creators
	end
end
