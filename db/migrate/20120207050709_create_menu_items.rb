class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.references :parent
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :menu_items, :parent_id
  end
end
