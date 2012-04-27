class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_fragment

	attr_accessor :content_fragment_type

	def summary
		if self.body.size > 200
			self.body[0,200].sub(/ [^ ]*$/, '...')
		else
			self.body
		end
	end

end
