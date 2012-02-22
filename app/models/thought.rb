class Thought < ContentFragment
	def self.random(count = 1)
		thoughts = Thought.where(:published => true)
		ret = []
		ids = []
		max = thoughts.count
		if count > max
			count = max
		end
		0.upto(count - 1) do
			id = rand(max)
			while ids.include?(id) do
				id = rand(max)
			end
			ids << id
			ret << thoughts[id]
		end
		ret
	end
end
