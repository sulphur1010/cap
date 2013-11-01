class AddHeaderToSentEmailMessages < ActiveRecord::Migration
  def change
    add_column :sent_email_messages, :header, :string
  end
end
