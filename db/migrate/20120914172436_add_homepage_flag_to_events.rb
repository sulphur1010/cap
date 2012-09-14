class AddHomepageFlagToEvents < ActiveRecord::Migration
  def change
		add_column :events, :featured, :boolean
		add_column :events, :allow_paypal, :boolean
		add_column :events, :allow_other_payment_type, :boolean
		add_column :events, :other_payment_type_text, :string
		add_column :events, :other_payment_type_instructions, :text
		add_column :events, :allow_discount, :boolean
		add_column :events, :discounted_text, :string
		add_column :events, :discounted_cost, :decimal, :precision => 8, :scale => 2
  end
end
