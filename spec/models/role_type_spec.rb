require 'spec_helper'

describe RoleType do

	it "should be valid" do
		rt = RoleType.make
		rt.should be_valid
	end

end

