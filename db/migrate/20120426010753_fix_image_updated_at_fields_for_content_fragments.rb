class FixImageUpdatedAtFieldsForContentFragments < ActiveRecord::Migration
  def up
		rename_column :content_fragments, :thumbnail_updaetd_at, :thumbnail_updated_at
		rename_column :content_fragments, :image_updaetd_at, :image_updated_at
  end

  def down
		rename_column :content_fragments, :thumbnail_updated_at, :thumbnail_updaetd_at
		rename_column :content_fragments, :image_updated_at, :image_updaetd_at
  end
end
