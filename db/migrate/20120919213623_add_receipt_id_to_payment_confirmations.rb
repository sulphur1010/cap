class AddReceiptIdToPaymentConfirmations < ActiveRecord::Migration
  def change
		add_column :payment_confirmations, :receipt_id, :string
  end
end
