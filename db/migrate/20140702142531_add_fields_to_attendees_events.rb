class AddFieldsToAttendeesEvents < ActiveRecord::Migration
	def change
		add_column :attendees_events, :occupation, :string
		add_column :attendees_events, :address, :string
		add_column :attendees_events, :city, :string
		add_column :attendees_events, :zip, :string
		add_column :attendees_events, :telephone, :string
		add_column :attendees_events, :fax, :string
		add_column :attendees_events, :mobile, :string
		add_column :attendees_events, :payment_method, :string
		add_column :attendees_events, :guest_name, :string
	end
end
