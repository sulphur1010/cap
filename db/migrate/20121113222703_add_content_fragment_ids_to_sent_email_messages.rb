class AddContentFragmentIdsToSentEmailMessages < ActiveRecord::Migration
	def up
		add_column :sent_email_messages, :content_fragment_ids, :string
	end

	def down
		remove_column :sent_email_messages, :content_fragment_ids
	end
end
