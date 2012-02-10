require 'spec_helper'

describe "Event requests" do

	describe "GET /event" do
		it "should return a valid page" do
			p = Event.make!
			get event_path(p)
			assert_response :success
		end
	end

	describe "GET unauthenticated /events" do
		it "should return a 404" do
			get "/events"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /events" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/events"
			assert_response :success
		end
	end

	describe "User GET authenticated /events" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/events"
			assert_response :missing
		end
	end
end
