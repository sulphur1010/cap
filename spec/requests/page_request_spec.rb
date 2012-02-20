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

end
