class Thought < ContentFragment
	def self.random
		thoughts = Thought.where(:published => true)
		thoughts[rand(thoughts.count)]
	end
end
