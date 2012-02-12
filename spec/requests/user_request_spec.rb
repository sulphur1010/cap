require 'spec_helper'

describe "User requests" do
	it "failed sign in should not create a current_user" do
		u = User.make!
		fail_sign_in(u)
		assert_response :success
		assert controller.current_user.should be_nil
	end
end
