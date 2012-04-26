class AddEncyclicalFieldsToContentFragments < ActiveRecord::Migration
  def change
		add_column :content_fragments, :translated_title, :string
  end
end
