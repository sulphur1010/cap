require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Contemporary Issue requests" do
	describe "GET unpublished /contemporary_issue" do
		it "should return a 404" do
			p = ContemporaryIssue.make!
			get contemporary_issue_path(p)
			assert_response :missing
		end
	end

	describe "GET published /contemporary_issue" do
		it "should return a valid page" do
			p = ContemporaryIssue.make!(:published => true)
			get contemporary_issue_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /contemporary_issues" do
		it "should return a 404" do
			get "/contemporary_issues"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /contemporary_issues" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/contemporary_issues"
			assert_response :success
		end
	end

	describe "User GET authenticated /contemporary_issues" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/contemporary_issues"
			assert_response :missing
		end
	end
end
