class AddCategoryToContentFragments < ActiveRecord::Migration
	def change
		add_column :content_fragments, :category, :string
	end
end
