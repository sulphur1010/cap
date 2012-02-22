class CreateEventsUsersTable < ActiveRecord::Migration
  def up
    create_table :events_users, :id => false do |t|
      t.references :event
      t.references :user
    end
  end

  def down
		drop_table :events_users
  end
end
