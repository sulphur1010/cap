class RemovePhoneFromUsers < ActiveRecord::Migration
	def up
		User.all.each do |user|
			contact = Contact.find_or_create_by_email(user.email)
			contact.phone = user.phone
			contact.save
		end
		remove_column :users, :phone
	end

	def down
	end
end
