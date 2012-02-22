class AddHideHeadersToContentFragments < ActiveRecord::Migration
  def change
		add_column :content_fragments, :hide_header, :boolean
  end
end
