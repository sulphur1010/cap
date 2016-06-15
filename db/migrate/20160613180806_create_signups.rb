class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
		t.timestamps
		t.string :last_name
		t.string :first_name
		t.string :occupation
		t.string :street
		t.string :city
		t.string :email
		t.string :zip
		t.string :tel
		t.string :fax
		t.string :mobile
		t.boolean :accompanied
		t.string :accompanied_by
		t.string :attendee_type
    end
  end
end
