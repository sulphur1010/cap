class AddContentFragmentTypeToEncyclicalReferences < ActiveRecord::Migration
	def change
		add_column :encyclical_references, :content_fragment_type, :string
	end
end
