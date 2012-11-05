class RemoveUserContactFields < ActiveRecord::Migration
	def up
		remove_column :users, :first_name
		remove_column :users, :last_name
		remove_column :users, :title
	end

	def down
		add_column :users, :first_name, :string
		add_column :users, :last_name, :string
		add_column :users, :title, :string
	end
end
