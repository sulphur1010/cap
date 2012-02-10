require 'spec_helper'

describe "Thought requests" do
	describe "GET unpublished /thought" do
		it "should return a 404" do
			p = Thought.make!
			get thought_path(p)
			assert_response :missing
		end
	end

	describe "GET published /thought" do
		it "should return a valid page" do
			p = Thought.make!(:published => true)
			get thought_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /thoughts" do
		it "should return a 404" do
			get "/thoughts"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /thoughts" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/thoughts"
			assert_response :success
		end
	end

	describe "User GET authenticated /thoughts" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/thoughts"
			assert_response :missing
		end
	end
end
