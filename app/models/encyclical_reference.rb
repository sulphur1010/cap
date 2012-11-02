class EncyclicalReference < ActiveRecord::Base
	belongs_to :content_fragment
	belongs_to :encyclical

	def reference=(ref)
		self.encyclical = Encyclical.find_by_reference_keyword(ref)
	end
end
