class AddEncyclicalChapterNumberToEncyclicalReferences < ActiveRecord::Migration
	def change
		add_column :encyclical_references, :chapter_number, :integer
		remove_column :encyclical_references, :encyclical_chapter_id
	end
end
