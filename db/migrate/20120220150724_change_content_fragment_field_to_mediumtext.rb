class ChangeContentFragmentFieldToMediumtext < ActiveRecord::Migration
	def up
		change_column :content_fragments, :body, :text
	end

	def down
		change_column :content_fragments, :body, :text
	end
end
