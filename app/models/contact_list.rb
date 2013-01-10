class ContactList < ActiveRecord::Base
	def contacts
		[]
	end

	def self.dynamic_contact_lists
		list = [
			AdminContactList.new,
			SpeakerContactList.new,
			ThoughtCreatorContactList.new,
			CelebrantContactList.new,
			LeadsContactList.new,
			AccountHoldersContactList.new
		]
		User.affiliation_types.each do |affiliate_type|
			list << AffiliateContactList.new(:sub_type => affiliate_type[1])
		end
		PersonType.all.each do |person_type|
			list << PersonTypeContactList.new(:sub_type => person_type)
		end
		list
	end

	def self.static_contact_lists
		StaticContactList.includes(:contacts)
	end

	def self.all_contact_lists
		ContactList.dynamic_contact_lists + ContactList.static_contact_lists
	end

	def display_name
		self.type.gsub("ContactList", '').titleize.pluralize
	end

	def value_name
		self.display_name.gsub(/ /, '').underscore.gsub(/,/, '')
	end

	def sub_type
		nil
	end
end
