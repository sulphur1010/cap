require 'spec_helper'

describe "Page requests" do
	describe "GET unpublished /some/url" do
		it "should return a 404" do
			p = Page.make!(:published => false)
			get "/some/url"
			assert_response :missing
		end
	end

	describe "GET published /some/url" do
		it "should return a valid page" do
			p = Page.make!
			get "/some/url"
			assert_response :success
		end
	end

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Page.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Page.count.should eq(1)
		Page.first.user.should eq(u)
	end

end
