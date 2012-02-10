require 'spec_helper'

def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

describe "Person Type requests" do
	describe "GET unpublished /person_type" do
		it "should return a 404" do
			p = PersonType.make!
			get person_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /person_type" do
		it "should return a valid page" do
			p = PersonType.make!(:published => true)
			get person_type_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /person_types" do
		it "should return a 404" do
			get "/person_types"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /person_types" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/person_types"
			assert_response :success
		end
	end

	describe "User GET authenticated /person_types" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/person_types"
			assert_response :missing
		end
	end
end
