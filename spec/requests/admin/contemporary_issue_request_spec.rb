require 'spec_helper'

describe "Contemporary Issue requests" do

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = ContemporaryIssue.make
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		ContemporaryIssue.count.should eq(1)
		ContemporaryIssue.first.user.should eq(u)
	end

end
