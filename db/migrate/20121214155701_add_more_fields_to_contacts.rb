class AddMoreFieldsToContacts < ActiveRecord::Migration
  def change
		rename_column :contacts, :phone, :work_phone
		add_column :contacts, :work_phone_ext, :string
		add_column :contacts, :middle_initial, :string
		add_column :contacts, :suffix, :string
		add_column :contacts, :address_3, :string
		add_column :contacts, :country, :string
		add_column :contacts, :mobile_phone, :string
		add_column :contacts, :home_phone, :string
  end
end
