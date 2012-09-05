class CreateFeedEntries < ActiveRecord::Migration
	def change
		create_table :feed_entries do |t|
			t.string :title
			t.string :url
			t.string :entry_id
			t.text :summary
			t.datetime :published_at
			t.integer :feed_source_id
			t.timestamps
		end
	end
end
