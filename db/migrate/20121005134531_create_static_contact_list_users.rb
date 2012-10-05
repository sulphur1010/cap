class CreateStaticContactListUsers < ActiveRecord::Migration
	def change
		create_table :contacts_static_contact_lists, :id => false do |t|
			t.integer :static_contact_list_id
			t.integer :contact_id
			t.timestamps
		end
	end
end
