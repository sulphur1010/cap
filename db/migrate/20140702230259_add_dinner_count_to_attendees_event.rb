class AddDinnerCountToAttendeesEvent < ActiveRecord::Migration
	def change
		add_column :attendees_events, :dinner_count, :integer
	end
end
