require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Role Type requests" do
	describe "GET unpublished /role_type" do
		it "should return a 404" do
			p = RoleType.make!
			get role_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /role_type" do
		it "should return a valid page" do
			p = RoleType.make!(:published => true)
			get role_type_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /role_types" do
		it "should return a 404" do
			get "/role_types"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /role_types" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/role_types"
			assert_response :success
		end
	end

	describe "User GET authenticated /role_types" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/role_types"
			assert_response :missing
		end
	end
end
