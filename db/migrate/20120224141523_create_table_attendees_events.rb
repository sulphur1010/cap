class CreateTableAttendeesEvents < ActiveRecord::Migration
  def up
		create_table :attendees_events, :id => false do |t|
			t.references :attendee
			t.references :event
			t.timestamps
		end
		add_index :attendees_events, :attendee_id
		add_index :attendees_events, :event_id
  end

  def down
		drop_table :attendees
  end
end
