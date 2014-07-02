class AddAdvancedPaymentsToEvents < ActiveRecord::Migration
	def change
		add_column :events, :display_advanced_payment_options, :boolean
		change_table :events do |t|
			t.has_attached_file :advanced_payment_form
		end
	end
end
