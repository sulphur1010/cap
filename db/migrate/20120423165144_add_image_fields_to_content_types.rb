class AddImageFieldsToContentTypes < ActiveRecord::Migration
  def change
		add_column :content_fragments, :thumbnail_content_type, :string
		add_column :content_fragments, :thumbnail_file_size, :integer
		add_column :content_fragments, :thumbnail_file_name, :string
		add_column :content_fragments, :thumbnail_updaetd_at, :datetime

		add_column :content_fragments, :image_content_type, :string
		add_column :content_fragments, :image_file_size, :integer
		add_column :content_fragments, :image_file_name, :string
		add_column :content_fragments, :image_updaetd_at, :datetime
  end
end
