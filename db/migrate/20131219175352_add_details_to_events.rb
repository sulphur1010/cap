class AddDetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :allow_3rd_party_payment, :boolean
    add_column :events, :allow_3rd_party_payment_url, :string
    add_column :events, :allow_3rd_party_payment_type_instructions, :text
  end
end
