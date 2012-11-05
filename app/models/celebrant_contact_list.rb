class CelebrantContactList < ContactList
	def contacts
		User.celebrants
	end
end
