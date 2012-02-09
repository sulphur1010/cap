require 'spec_helper'

describe Chapter do
  it "should be valid" do
		c = Chapter.make!
		c.should be_valid
	end
end
