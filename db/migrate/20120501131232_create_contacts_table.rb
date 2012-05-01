class CreateContactsTable < ActiveRecord::Migration
  def up
		create_table :contacts do |t|
			t.string :prefix
			t.string :first_name
			t.string :last_name
			t.string :email
			t.string :address
			t.string :address_2
			t.string :city
			t.string :state
			t.string :zip_code
			t.string :phone
		end

		EmailAddress.all.each do |email_address|
			c = Contact.new
			c.email = email_address.email
			c.save
		end

  end

  def down
		drop_table :contacts
  end
end
