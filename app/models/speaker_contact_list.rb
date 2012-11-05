class SpeakerContactList < ContactList
	def contacts
		User.speakers
	end
end
