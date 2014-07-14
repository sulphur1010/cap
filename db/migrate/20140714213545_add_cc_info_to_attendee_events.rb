class AddCcInfoToAttendeeEvents < ActiveRecord::Migration
	def change
		add_column :attendees_events, :cc_number, :string
		add_column :attendees_events, :cc_month, :integer
		add_column :attendees_events, :cc_year, :integer
	end
end
