class CreateContentFragments < ActiveRecord::Migration
  def change
    create_table :content_fragments do |t|
      t.string :title
      t.references :user
      t.text :body
      t.boolean :published
      t.datetime :published_at
      t.text :teaser
      t.string :type

      t.timestamps
    end
    add_index :content_fragments, :user_id
  end
end
