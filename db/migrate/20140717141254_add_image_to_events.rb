class AddImageToEvents < ActiveRecord::Migration
	def change
		change_table :events do |t|
			t.has_attached_file :image
		end
	end
end
