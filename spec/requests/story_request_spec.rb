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
end
