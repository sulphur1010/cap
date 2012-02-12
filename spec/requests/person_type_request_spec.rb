require 'spec_helper'

describe "Person Type requests" do
	describe "GET unpublished /person_type" do
		it "should return a 404" do
			p = PersonType.make!(:published => false)
			get person_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /person_type" do
		it "should return a valid page" do
			p = PersonType.make!
			get person_type_path(p)
			assert_response :success
		end
	end

	it "should have a user" do
		u = User.make!(:admin)
		sign_in(u)
		obj = PersonType.make
		post url_for(obj), obj.class.to_s.downcase.to_sym => obj.attributes
		assert_response 302
		PersonType.count.should eq(1)
		PersonType.first.user.should eq(u)
	end

end
