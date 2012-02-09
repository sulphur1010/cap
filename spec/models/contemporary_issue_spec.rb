require 'spec_helper'

describe ContemporaryIssue do

	it "should be valid" do
		ci = ContemporaryIssue.make
		ci.should be_valid
	end

end

