require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Location requests" do
	describe "GET /location" do
		it "should return a valid page" do
			p = Location.make!
			get location_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /locations" do
		it "should return a 404" do
			get "/locations"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /locations" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/locations"
			assert_response :success
		end
	end

	describe "User GET authenticated /locations" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/locations"
			assert_response :missing
		end
	end
end
