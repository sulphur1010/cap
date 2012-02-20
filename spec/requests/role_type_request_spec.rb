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
end
