require 'spec_helper'

describe "Thought requests" do
	describe "GET unpublished /thought" do
		it "should return a 404" do
			p = Thought.make!(:published => false)
			get thought_path(p)
			assert_response :missing
		end
	end

	describe "GET published /thought" do
		it "should return a valid page" do
			p = Thought.make!
			get thought_path(p)
			assert_response :success
		end
	end
end
