class AddFieldsToPaymentConfirmations < ActiveRecord::Migration
	def change
		add_column :payment_confirmations, :attendees_event_id, :integer
		add_column :payment_confirmations, :event_id, :integer
		add_column :payment_confirmations, :user_id, :integer
	end
end
