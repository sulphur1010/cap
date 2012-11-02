class AddFieldsToEncyclicalReferences < ActiveRecord::Migration
  def change
		add_column :encyclical_references, :encyclical_chapter_id, :integer
		remove_column :encyclical_references, :start
		remove_column :encyclical_references, :end
  end
end
