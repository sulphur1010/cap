class AddPrimaryKeyToAttendeesEvents < ActiveRecord::Migration
	def change
		add_column :attendees_events, :id, :primary_key
	end
end
