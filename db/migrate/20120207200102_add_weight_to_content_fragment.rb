class AddWeightToContentFragment < ActiveRecord::Migration
  def change
    add_column :content_fragments, :weight, :integer
  end
end
