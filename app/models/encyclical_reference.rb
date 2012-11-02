class EncyclicalReference < ActiveRecord::Base
	belongs_to :content_fragment
	belongs_to :encyclical

	before_save :populate_content_fragment_type

	def reference=(ref)
		self.encyclical = Encyclical.find_by_reference_keyword(ref)
	end

	def populate_content_fragment_type
		if self.content_fragment_type.blank? || (self.content_fragment && self.content_fragment_changed?)
			self.content_fragment_type = self.content_fragment.type
		end
	end
end
