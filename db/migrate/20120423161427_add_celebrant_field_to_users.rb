class AddCelebrantFieldToUsers < ActiveRecord::Migration
  def change
		add_column :users, :celebrant, :boolean, :default => false
  end
end
