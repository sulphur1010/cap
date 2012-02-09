class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.datetime :start_date
      t.datetime :end_date
      t.references :speaker
      t.string :title
      t.references :location
      t.text :body
      t.references :director
      t.integer :spots_available
      t.integer :cost
      t.references :chapter

      t.timestamps
    end

    add_index :events, :speaker_id
    add_index :events, :location_id
    add_index :events, :director_id
    add_index :events, :chapter_id

    create_table :contemporary_issues_events, :id => false do |t|
      t.references :contemporary_issue
      t.references :event
    end

    create_table :events_person_types, :id => false do |t|
      t.references :event
      t.references :person_type
    end
  end
end
