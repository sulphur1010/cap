class RemoveAnswers < ActiveRecord::Migration
  def up
		drop_table :answers
  end

  def down
    create_table :answers do |t|
      t.references :user
      t.references :question
      t.text :body

      t.timestamps
    end
    add_index :answers, :user_id
    add_index :answers, :question_id
  end
end
