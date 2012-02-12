require 'spec_helper'

describe "Contemporary Issue requests" do
	describe "GET unpublished /contemporary_issue" do
		it "should return a 404" do
			p = ContemporaryIssue.make!(:published => false)
			get contemporary_issue_path(p)
			assert_response :missing
		end
	end

	describe "GET published /contemporary_issue" do
		it "should return a valid page" do
			p = ContemporaryIssue.make!
			get contemporary_issue_path(p)
			assert_response :success
		end
	end

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = ContemporaryIssue.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		ContemporaryIssue.count.should eq(1)
		ContemporaryIssue.first.user.should eq(u)
	end

end
