class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user
      t.references :content_fragment
      t.text :body

      t.timestamps
    end
    add_index :questions, :user_id
    add_index :questions, :content_fragment_id
  end
end
