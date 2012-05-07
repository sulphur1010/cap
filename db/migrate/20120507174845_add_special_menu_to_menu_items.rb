class AddSpecialMenuToMenuItems < ActiveRecord::Migration
  def change
		add_column :menu_items, :menu_type, :string
  end
end
