require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Prism Type requests" do
	describe "GET unpublished /prism_type" do
		it "should return a 404" do
			p = PrismType.make!
			get prism_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /prism_type" do
		it "should return a valid page" do
			p = PrismType.make!(:published => true)
			get prism_type_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /prism_types" do
		it "should return a 404" do
			get "/prism_types"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /prism_types" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/prism_types"
			assert_response :success
		end
	end

	describe "User GET authenticated /prism_types" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/prism_types"
			assert_response :missing
		end
	end
end
