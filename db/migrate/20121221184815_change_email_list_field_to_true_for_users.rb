class ChangeEmailListFieldToTrueForUsers < ActiveRecord::Migration
  def up
		change_column :users, :email_list, :boolean, :default => true
		User.all.each do |user|
			user.email_list = true
			user.save!
		end
  end

  def down
		change_column :users, :email_list, :boolean
  end
end
