class StaffContactList < ContactList
	def contacts
		User.staff
	end
end
