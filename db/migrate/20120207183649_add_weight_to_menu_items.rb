class AddWeightToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :weight, :integer
  end
end
