require 'spec_helper'

describe "Role Type requests" do
	describe "GET unpublished /role_type" do
		it "should return a 404" do
			p = RoleType.make!(:published => false)
			get role_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /role_type" do
		it "should return a valid page" do
			p = RoleType.make!
			get role_type_path(p)
			assert_response :success
		end
	end

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = RoleType.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		RoleType.count.should eq(1)
		RoleType.first.user.should eq(u)
	end

end
