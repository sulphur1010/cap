class AddMorePaymentConfirmationsFields < ActiveRecord::Migration
  def up
		add_column :payment_confirmations, :item_isbn1, :string
		add_column :payment_confirmations, :item_plu1, :string
		add_column :payment_confirmations, :item_style_number1, :string
		add_column :payment_confirmations, :item_tax_rate_double1, :string
		add_column :payment_confirmations, :tax1, :string
		add_column :payment_confirmations, :item_tax_rate1, :string
		add_column :payment_confirmations, :item_count_unit1, :string
		add_column :payment_confirmations, :item_mpn1, :string
		add_column :payment_confirmations, :item_model_number1, :string
  end

  def down
		remove_column :payment_confirmations, :item_isbn1
		remove_column :payment_confirmations, :item_plu1
		remove_column :payment_confirmations, :item_style_number1
		remove_column :payment_confirmations, :item_tax_rate_double1
		remove_column :payment_confirmations, :tax1
		remove_column :payment_confirmations, :item_tax_rate1
		remove_column :payment_confirmations, :item_count_unit1
		remove_column :payment_confirmations, :item_mpn1
		remove_column :payment_confirmations, :item_model_number1
  end
end
