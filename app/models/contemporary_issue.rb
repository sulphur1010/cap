class ContemporaryIssue < ContentFragment
	has_and_belongs_to_many :content_fragments
	has_and_belongs_to_many :events
	has_and_belongs_to_many :users

	def speakers
		self.users.where(:speaker => true)
	end

	def random_thought
		thoughts = self.content_fragments.published.where(:type => 'Thought')
		thoughts[rand(thoughts.count)]
	end

end
