require 'spec_helper'

describe "Block requests" do

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Block.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Block.count.should eq(1)
		Block.first.user.should eq(u)
	end

end
