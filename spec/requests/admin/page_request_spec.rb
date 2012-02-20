require 'spec_helper'

describe "Page requests" do
	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Page.make
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Page.count.should eq(1)
		Page.first.user.should eq(u)
	end

end
