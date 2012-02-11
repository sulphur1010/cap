class AddProfileImageToUsers < ActiveRecord::Migration
	def change
		change_table :users do |t|
			t.has_attached_file :profile_image
		end
	end
end
