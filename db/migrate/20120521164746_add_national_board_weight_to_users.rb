class AddNationalBoardWeightToUsers < ActiveRecord::Migration
  def change
		add_column :users, :national_board_weight, :integer
  end
end
