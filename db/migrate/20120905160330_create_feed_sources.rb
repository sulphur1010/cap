class CreateFeedSources < ActiveRecord::Migration
	def change
		create_table :feed_sources do |t|
			t.string :title
			t.string :url
			t.text :description
			t.string :link
			t.timestamps
		end
	end
end
