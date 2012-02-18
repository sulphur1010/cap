require 'spec_helper'

describe Story do

	it "should be valid" do
		p = Story.make!
		p.should be_valid
	end

	it "should be invalid without a category" do
		e = Story.make(:category => nil)
		e.should have(1).errors_on(:category)
	end
end

