class AddUserFieldsToRsvp < ActiveRecord::Migration
	def change
		add_column :attendees_events, :email, :string
		add_column :attendees_events, :first_name, :string
		add_column :attendees_events, :last_name, :string
	end
end
