class AddNameToContentFragments < ActiveRecord::Migration
  def change
    add_column :content_fragments, :name, :string
  end
end
