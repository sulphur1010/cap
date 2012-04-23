class MoveCelebrantEventsToCelebrantsEvents < ActiveRecord::Migration
  def up
		rename_table :celebrant_events, :celebrants_events
  end

  def down
		rename_table :celebrants_events, :celebrant_events
  end
end
