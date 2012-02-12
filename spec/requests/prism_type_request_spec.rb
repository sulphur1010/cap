require 'spec_helper'

describe "Prism Type requests" do
	describe "GET unpublished /prism_type" do
		it "should return a 404" do
			p = PrismType.make!(:published => false)
			get prism_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /prism_type" do
		it "should return a valid page" do
			p = PrismType.make!
			get prism_type_path(p)
			assert_response :success
		end
	end

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = PrismType.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		PrismType.count.should eq(1)
		PrismType.first.user.should eq(u)
	end

end
