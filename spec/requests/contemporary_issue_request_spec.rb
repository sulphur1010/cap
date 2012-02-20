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

end
