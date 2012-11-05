class MoveContactInformation < ActiveRecord::Migration
	def up
		User.all.each do |user|
			contact = Contact.find_or_create_by_email(user.email)
			contact.email = user.email
			contact.first_name = user.first_name
			contact.last_name = user.last_name
			contact.title = user.title
			contact.save
		end
	end

	def down
	end
end
