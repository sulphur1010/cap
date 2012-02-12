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

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = Thought.make
		obj.user = u
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		Thought.count.should eq(1)
		Thought.first.user.should eq(u)
	end

end
