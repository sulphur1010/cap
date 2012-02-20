require 'spec_helper'

describe "Prism Type requests" do
	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = PrismType.make
		post url_for([:admin, obj]), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		PrismType.count.should eq(1)
		PrismType.first.user.should eq(u)
	end

end
