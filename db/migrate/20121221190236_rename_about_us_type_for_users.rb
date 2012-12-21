class RenameAboutUsTypeForUsers < ActiveRecord::Migration
  def up
		rename_column :users, :about_us_type, :affiliation_list
  end

  def down
		rename_column :users, :affiliation_list, :about_us_type
  end
end
