require 'spec_helper'

describe "Story requests" do
	describe "GET unpublished /some/url" do
		it "should return a 404" do
			p = Story.make!(:published => false)
			get story_path(p)
			assert_response :missing
		end
	end

	describe "GET published /some/url" do
		it "should return a valid story" do
			p = Story.make!
			get story_path(p)
			assert_response :success
		end
	end

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Story.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Story.count.should eq(1)
		Story.first.user.should eq(u)
	end

end
