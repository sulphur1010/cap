class Admin::AttendeesEventsController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def destroy
		@event = Event.find(params[:event_id])
		@attendee_event = AttendeesEvent.find(params[:id])
		if @event == @attendee_event.event
			@attendee_event.destroy
		end
		redirect_to event_path(@event)
	end
end
