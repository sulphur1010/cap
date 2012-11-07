class CreateSendEmailMessages < ActiveRecord::Migration
	def change
		create_table :sent_email_messages do |t|
			t.string :subject
			t.text :to
			t.text :body
			t.string :status
			t.integer :user_id
			t.timestamps
		end
	end
end
