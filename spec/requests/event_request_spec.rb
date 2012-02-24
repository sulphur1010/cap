require 'spec_helper'

describe "Event requests" do

	describe "GET /event" do
		it "should return a valid page" do
			p = Event.make!
			get event_path(p)
			assert_response :success
		end
	end

	describe "POST /events/1/rsvp" do
		it "should redirect to registration page" do
			e = Event.make!
			post rsvp_event_url(e)
			response.should redirect_to(new_user_registration_url)
		end

		it "should have an attendee" do
			e = Event.make!(:spots_available => 1)
			e.attendees.count.should eq(0)
			u = User.make!
			sign_in(u)
			post rsvp_event_url(e)
			response.should redirect_to(event_url(e))
			Event.first.attendees.count.should eq(1)
		end

	end

end
