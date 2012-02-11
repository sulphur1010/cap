class EncyclicalReference < ActiveRecord::Base
	belongs_to :content_fragment
	belongs_to :encyclical

	before_save :ensure_positions

	private

	def ensure_positions
		self.start = 0 if self.start == nil
		self.end = 0 if self.end == nil
	end
end
