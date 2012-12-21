class AccountHoldersContactList < ContactList
	def contacts
		User.where(:email_list => true).all
	end
end

