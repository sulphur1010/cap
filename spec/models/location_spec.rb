require 'spec_helper'

describe Location do
	it "should be valid" do
		l = Location.make
		l.should be_valid
	end
end
