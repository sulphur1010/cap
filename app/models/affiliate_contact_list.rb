class AffiliateContactList < ContactList

	attr_accessor :sub_type

	def contacts
		return [] unless self.sub_type
		User.where("affiliation_list LIKE '%#{self.sub_type}%'")
	end

	def display_name
		if self.sub_type
			"Affiliate - #{User.affiliation_types.select { |c| c[1] == self.sub_type }.first[0]}"
		else
			"Affiliate"
		end
	end
end
