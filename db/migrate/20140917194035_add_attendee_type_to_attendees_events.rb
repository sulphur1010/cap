class AddAttendeeTypeToAttendeesEvents < ActiveRecord::Migration
	def change
		add_column :attendees_events, :attendee_type, :string
	end
end
