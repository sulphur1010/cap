class AddAnswerToQuestions < ActiveRecord::Migration
  def change
		add_column :questions, :answer_body, :text
  end
end
