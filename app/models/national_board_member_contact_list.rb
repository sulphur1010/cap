class NationalBoardMemberContactList < ContactList
	def contacts
		User.national_board_members
	end
end
