require 'spec_helper'

def sign_in(user)
	get new_user_session_path
	assert_response :success
	post user_session_path, :email => user.email, :password => 'password'
	assert_response :success
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

	describe "GET authenticated /pages" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/pages"
			assert_response :success
		end
	end

end
