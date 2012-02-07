class AddUrlToContentFragments < ActiveRecord::Migration
  def change
    add_column :content_fragments, :url, :string
    add_index :content_fragments, :url, :unique => true
  end
end
