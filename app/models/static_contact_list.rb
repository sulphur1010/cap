class StaticContactList < ContactList
	has_and_belongs_to_many :contacts
	belongs_to :user

	validates :name, :presence => true

	def display_name
		self.name
	end
end
