class AddMenuTypes < ActiveRecord::Migration
	def up
		add_column :menu_items, :menu, :string
		add_column :content_fragments, :menu, :string
	end

	def down
		remove_column :menu_items, :menu
		remove_column :content_fragments, :menu
	end
end
