class AddEventFields < ActiveRecord::Migration
	def up
		add_column :events, :event_type, :string
		add_column :events, :event_region, :string
	end

	def down
		remove_column :events, :event_type
		remove_column :events, :event_region
	end
end
