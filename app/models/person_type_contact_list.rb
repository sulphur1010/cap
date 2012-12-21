class PersonTypeContactList < ContactList

	attr_accessor :sub_type

	def contacts
		return [] unless self.sub_type
		User.where(:person_type_id => self.sub_type)
	end

	def display_name
		if self.sub_type
			person_type = PersonType.find(self.sub_type)
			"Person Type - #{person_type.name}"
		else
			"Person Type"
		end
	end
end

