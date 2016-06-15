class AddPaypalIdToSignup < ActiveRecord::Migration
  def change
    add_column :signups, :paypal_id, :string
  end
end
