class EncyclicalChapter < ActiveRecord::Base
  belongs_to :encyclical

	searchable :include => [:encyclical] do
		integer :chapter_num
		text :chapter_body
		integer :encyclical_id
	end

end
