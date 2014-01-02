class CreateRelatedEvents < ActiveRecord::Migration
  def change
    create_table "relateds_events", :id => false, :force => true do |t|
	    t.integer "event_id"
	    t.integer "related_event_id"
   	end
   	add_index "relateds_events", ["event_id"], :name => "index_related_events_on_event_id"
  	add_index "relateds_events", ["related_event_id"], :name => "index_related_events_events_on_related_event_id"
  end
end
