class AddPaymentConfirmationFields < ActiveRecord::Migration
  def up
		add_column :payment_confirmations, :item_taxable1, :string
  end

  def down
		remove_column :payment_confirmations, :item_taxable1
  end
end
