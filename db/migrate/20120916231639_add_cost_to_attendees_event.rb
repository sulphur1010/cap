class AddCostToAttendeesEvent < ActiveRecord::Migration
  def change
		add_column :attendees_events, :total_cost, :decimal, :precision => 8, :scale => 2
  end
end
