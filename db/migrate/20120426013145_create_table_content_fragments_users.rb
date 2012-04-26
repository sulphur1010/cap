class CreateTableContentFragmentsUsers < ActiveRecord::Migration
  def up
		create_table :content_fragments_users, :id => false do |t|
			t.references :user
			t.references :content_fragment
			t.timestamps
		end
		add_index :content_fragments_users, :user_id
		add_index :content_fragments_users, :content_fragment_id
  end

  def down
		drop_table :content_fragments_users
  end
end
