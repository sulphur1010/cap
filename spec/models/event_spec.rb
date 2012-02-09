require 'spec_helper'

describe Event do
	it "should be valid" do
		e = Event.make!
    e.should be_valid
  end

	it "should be invalid without a type" do
		e = Event.make(:type => nil)
    e.should have(1).errors_on(:type)
	end

  it "shouldn't be valid with a start_date and no end_date" do
    e = Event.make(:start_date => Time.now)
    e.should have(1).errors_on(:end_date)
  end

  it "shouldn'tbe valid with a start_date less than end_date" do
    e = Event.make(:start_date => Time.now, :end_date => Time.now - 10)
    e.should have(1).errors_on(:end_date)
  end

end
