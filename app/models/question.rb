class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_fragment
	has_many :answers

	attr_accessor :content_fragment_type

	def summary
		self.body[0,255]
	end

end
