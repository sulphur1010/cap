class CreateEncyclicalChapters < ActiveRecord::Migration
  def change
    create_table :encyclical_chapters do |t|
      t.references :encyclical
      t.integer :chapter_num
      t.text :chapter_body

      t.timestamps
    end
    add_index :encyclical_chapters, :encyclical_id
		add_index :encyclical_chapters, :chapter_num
  end
end
