require 'spec_helper'

describe Principle do

	it "should be valid" do
		pt = Principle.make
		pt.should be_valid
	end

end

