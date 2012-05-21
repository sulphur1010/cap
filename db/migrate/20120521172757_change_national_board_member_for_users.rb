class ChangeNationalBoardMemberForUsers < ActiveRecord::Migration
  def up
		change_column :users, :national_board_member, :string
		rename_column :users, :national_board_member, :about_us_type
  end

  def down
		rename_column :users, :about_us_type, :national_board_member
		change_column :users, :national_board_member, :boolean
  end
end
