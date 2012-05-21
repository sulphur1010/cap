class RenameNationalBoardWeightForUsers < ActiveRecord::Migration
  def up
		rename_column :users, :national_board_weight, :about_us_weight
  end

  def down
		rename_column :users, :about_us_weight, :national_board_weight
  end
end
