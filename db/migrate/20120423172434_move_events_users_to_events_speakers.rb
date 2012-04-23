class MoveEventsUsersToEventsSpeakers < ActiveRecord::Migration
  def up
		rename_table :events_users, :events_speakers
  end

  def down
		rename_table :events_speakers, :events_users
  end
end
