class AddExtraFieldsToUsers < ActiveRecord::Migration
  def change
		add_column :users, :first_name, :string
		add_column :users, :last_name, :string
		add_column :users, :title, :string
		add_column :users, :person_type_id, :integer
		add_column :users, :speaker, :boolean
		add_column :users, :role_list, :string
  end
end
