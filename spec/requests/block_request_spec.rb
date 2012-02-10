require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Block requests" do
	describe "GET unauthenticated /blocks" do
		it "should return a 404" do
			get "/blocks"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /blocks" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/blocks"
			assert_response :success
		end
	end

	describe "User GET authenticated /blocks" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/blocks"
			assert_response :missing
		end
	end
end
