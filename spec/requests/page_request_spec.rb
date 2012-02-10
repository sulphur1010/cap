require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Page requests" do
	describe "GET unpublished /some/url" do
		it "should return a 404" do
			p = Page.make!
			get "/some/url"
			assert_response :missing
		end
	end

	describe "GET published /some/url" do
		it "should return a valid page" do
			p = Page.make!(:published => true)
			get "/some/url"
			assert_response :success
		end
	end

	describe "GET unauthenticated /pages" do
		it "should return a 404" do
			get "/pages"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /pages" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/pages"
			assert_response :success
		end
	end

	describe "User GET authenticated /pages" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/pages"
			assert_response :missing
		end
	end
end
