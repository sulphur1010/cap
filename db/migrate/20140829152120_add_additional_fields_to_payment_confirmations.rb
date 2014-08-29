class AddAdditionalFieldsToPaymentConfirmations < ActiveRecord::Migration
  def change
		add_column :payment_confirmations, :item_number2, :integer
		add_column :payment_confirmations, :mc_handling2, :float
		add_column :payment_confirmations, :mc_shipping2, :float
		add_column :payment_confirmations, :tax2, :float
		add_column :payment_confirmations, :item_name2, :string
		add_column :payment_confirmations, :quantity2, :integer
		add_column :payment_confirmations, :mc_gross_2, :float

		add_column :payment_confirmations, :item_number3, :integer
		add_column :payment_confirmations, :mc_handling3, :float
		add_column :payment_confirmations, :mc_shipping3, :float
		add_column :payment_confirmations, :tax3, :float
		add_column :payment_confirmations, :item_name3, :string
		add_column :payment_confirmations, :quantity3, :integer
		add_column :payment_confirmations, :mc_gross_3, :float
  end
end
