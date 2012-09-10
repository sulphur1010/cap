class CreateEventReminders < ActiveRecord::Migration
  def change
    create_table :event_reminders do |t|
      t.references :event
      t.integer :duration
      t.boolean :sent
      t.datetime :sent_at

      t.timestamps
    end
    add_index :event_reminders, :event_id
		add_index :event_reminders, :sent
		add_index :event_reminders, :sent_at
  end
end
