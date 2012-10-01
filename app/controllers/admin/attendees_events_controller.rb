class Admin::AttendeesEventsController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def create
		@event = Event.find(params[:event_id])
		@attendee_event = AttendeesEvent.new(params[:attendees_event])
		@attendee_event.event = @event
		if @attendee_event.save
			flash[:notice] = "User added to event"
			redirect_to event_path(@event)
		else
			flash[:notice] = "Error adding user to event"
			redirect_to event_path(@event)
		end
	end

	def destroy
		@event = Event.find(params[:event_id])
		@attendee_event = AttendeesEvent.find(params[:id])
		if @event == @attendee_event.event
			@attendee_event.destroy
		end
		redirect_to event_path(@event)
	end
end
