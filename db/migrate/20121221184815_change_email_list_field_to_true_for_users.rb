class ChangeEmailListFieldToTrueForUsers < ActiveRecord::Migration
  def up
		change_column :users, :email_list, :boolean, :default => true
  end

  def down
		change_column :users, :email_list, :boolean
  end
end
