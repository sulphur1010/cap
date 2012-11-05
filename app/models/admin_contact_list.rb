class AdminContactList < ContactList
	def contacts
		User.admins
	end
end
