class CreateReferences < ActiveRecord::Migration
	def change
		create_table :encyclical_references do |t|
			t.references :content_fragment
			t.references :encyclical
			t.integer :start
			t.integer :end

			t.timestamps
		end
		add_index :encyclical_references, :content_fragment_id
		add_index :encyclical_references, :encyclical_id
	end
end
