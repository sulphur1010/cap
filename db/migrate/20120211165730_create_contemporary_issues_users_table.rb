class CreateContemporaryIssuesUsersTable < ActiveRecord::Migration
  def up
    create_table :contemporary_issues_users, :id => false do |t|
      t.references :contemporary_issue
      t.references :user
    end
  end

  def down
    drop_table :contemporary_issues_users
  end
end
