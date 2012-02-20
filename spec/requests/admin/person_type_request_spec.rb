require 'spec_helper'

describe "Person Type requests" do
	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = PersonType.make
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		PersonType.count.should eq(1)
		PersonType.first.user.should eq(u)
	end

end
