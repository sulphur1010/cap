class StaticContactList < ContactList
	#has_many :contacts, :class_name => StaticContactListContact, :foreign_key => :contact_list_id
	has_and_belongs_to_many :contacts
end
