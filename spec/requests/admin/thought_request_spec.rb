require 'spec_helper'

describe "Thought requests" do
	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Thought.make
		obj.user = u
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Thought.count.should eq(1)
		Thought.first.user.should eq(u)
	end

end
