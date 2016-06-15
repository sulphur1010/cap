class AddDinnerToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :dinner, :boolean
  end
end
