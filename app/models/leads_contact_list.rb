class LeadsContactList < ContactList
	def contacts
		Contact.includes(:user).select { |c| !c.user }
	end
end

