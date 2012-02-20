require 'spec_helper'

describe "Story requests" do
	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Story.make
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Story.count.should eq(1)
		Story.first.user.should eq(u)
	end

end
