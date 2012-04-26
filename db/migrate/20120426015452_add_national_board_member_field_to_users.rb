class AddNationalBoardMemberFieldToUsers < ActiveRecord::Migration
  def change
		add_column :users, :national_board_member, :boolean
  end
end
