class AddCountToAttendeesEvents < ActiveRecord::Migration
  def change
		add_column :attendees_events, :count, :integer
  end
end
