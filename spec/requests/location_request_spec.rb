require 'spec_helper'

describe "Location requests" do
	describe "GET /location" do
		it "should return a valid page" do
			p = Location.make!
			get location_path(p)
			assert_response :success
		end
	end
end
