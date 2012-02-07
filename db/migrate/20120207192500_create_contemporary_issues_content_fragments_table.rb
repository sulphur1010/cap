class CreateContemporaryIssuesContentFragmentsTable < ActiveRecord::Migration
  def up
    create_table :contemporary_issues_content_fragments, :id => false do |t|
      t.references :contemporary_issue
      t.references :content_fragment
    end
  end

  def down
    drop_table :contemporary_issues_content_fragments
  end
end
