require 'spec_helper'

describe "Event requests" do

	describe "GET /event" do
		it "should return a valid page" do
			p = Event.make!
			get event_path(p)
			assert_response :success
		end
	end
end
