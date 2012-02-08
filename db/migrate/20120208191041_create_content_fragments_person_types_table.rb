class CreateContentFragmentsPersonTypesTable < ActiveRecord::Migration
  def up
    create_table :content_fragments_person_types, :id => false do |t|
      t.references :content_fragment
      t.references :person_type
    end
  end

  def down
    drop_table :content_fragments_person_types
  end
end
