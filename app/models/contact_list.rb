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
			NationalBoardMemberContactList.new,
			StaffContactList.new,
			ChapterPresidentContactList.new
		]
		Chapter.all.each do |chapter|
			list << ChapterContactList.new(:chapter => chapter)
		end
		list
	end

	def self.all_contact_lists
		ContactList.dynamic_contact_lists + StaticContactList.includes(:contacts)
	end

	def display_name
		self.type.gsub("ContactList", '').titleize.pluralize
	end
end
