class AddMenuIndexToMenuItems < ActiveRecord::Migration
	def change
		add_index :menu_items, :menu
	end
end
