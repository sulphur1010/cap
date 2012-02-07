class ContentFragment < ActiveRecord::Base
  belongs_to :user

	alias :author :user

	before_save :set_type

	private

	def set_type
		self.type = 'ContentFragment' unless self.type
	end

end
