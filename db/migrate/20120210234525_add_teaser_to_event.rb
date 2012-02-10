class AddTeaserToEvent < ActiveRecord::Migration
  def change
    add_column :events, :teaser, :text
  end
end
