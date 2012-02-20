require 'spec_helper'

describe "Role Type requests" do
	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = RoleType.make
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		RoleType.count.should eq(1)
		RoleType.first.user.should eq(u)
	end

end
