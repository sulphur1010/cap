class LeadsContactList < ContactList
	def contacts
		Contact.select { |c| !c.user }
	end
end

