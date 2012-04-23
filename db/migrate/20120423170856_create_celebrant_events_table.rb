class CreateCelebrantEventsTable < ActiveRecord::Migration
  def up
		create_table :celebrant_events, :id => false do |t|
			t.integer :user_id
			t.integer :event_id
		end

		add_index :celebrant_events, :user_id
		add_index :celebrant_events, :event_id
  end

  def down
		drop_table :celebrant_events
  end
end
