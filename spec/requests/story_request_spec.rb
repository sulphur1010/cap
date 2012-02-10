require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Story requests" do
	describe "GET unpublished /some/url" do
		it "should return a 404" do
			p = Story.make!
			get story_path(p)
			assert_response :missing
		end
	end

	describe "GET published /some/url" do
		it "should return a valid story" do
			p = Story.make!(:published => true)
			get story_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /storys" do
		it "should return a 404" do
			get "/stories"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /storys" do
		it "should return a valid story" do
			u = User.make!(:admin)
			sign_in(u)
			get "/stories"
			assert_response :success
		end
	end

	describe "User GET authenticated /storys" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/stories"
			assert_response :missing
		end
	end
end
