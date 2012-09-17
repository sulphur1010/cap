class EventsController < ApplicationController

	respond_to :html

	def index
		@events = Event.upcoming
		process_events_search
	end

	def past
		@events = Event.past
		process_events_search
	end

	def show
		respond_with(@event = Event.find(params[:id]))
	end

	def thanks
		respond_with(@event = Event.find(params[:id]))
	end

	def rsvp
		@event = Event.find(params[:id])
		unless user_signed_in?
			return_url = rsvp_event_url(@event)
			return_url = params[:return_url] if params[:return_url]
			session[:return_url] = return_url
			redirect_to new_user_registration_url, :notice => 'You must register in order to RSVP.'
			return
		end
		count = params[:count].to_i
		if (@event.spots_left - count) > 0

			# we only get to this action if the other payment type is enabled for the event
			if !@event.allow_other_payment_type
				redirect_to event_url(@event), :notice => 'You must register for that event through a payment method.'
			end

			if @event.attendees.include?(current_user)
				redirect_to events_url, :notice => 'You are already attending that event.'
				return
			end
			ae = AttendeesEvent.new
			ae.attendee = current_user
			ae.event = @event
			ae.count = params[:count]
			ae.total_cost = params[:total_cost]
			ae.save!

			UserMailer.event_register_user(@event, current_user).deliver

			redirect_to @event, :notice => 'You have registered to attend the event.'
		else
			redirect_to events_url, :alert => 'There are no spots available for that event.'
		end
	end

	def unrsvp
		@event = Event.find(params[:id])
		unless user_signed_in?
			session[:return_url] = unrsvp_event_url(@event)
			redirect_to new_user_session_url, :notice => 'You must sign in to unRSVP.'
			return
		end
		if @event.attendees.include?(current_user)
			@event.attendees.delete(current_user)
			redirect_to @event, :notice => 'You have unregistered to attend the event.'
		else
			redirect_to events_url, :alert => 'You are not attending that event.'
		end
	end

	private

	def process_events_search
		if request.xhr?
			if params[:event_type]
				types = params[:event_type].split(/,/)
				if types.count > 0
					ews = []
					types.each do |t|
						ews << "type = '#{t}'"
					end
					@events = @events.where(ews.join(" OR "))
				end
			end
			if params[:event_region]
				types = params[:event_region].split(/,/)
				if types.count > 0
					ews = []
					types.each do |t|
						ews << "event_region = '#{t}'"
					end
					@events = @events.where(ews.join(" OR "))
				end
			end
			if params[:contemporary_issue]
				ids = params[:contemporary_issue].split(/,/)
				if ids.count > 0
					ciws = []
					ids.each do |id|
						ciws << "contemporary_issues_events.contemporary_issue_id = #{id}"
					end
					@events = @events.joins("JOIN contemporary_issues_events ON contemporary_issues_events.event_id = events.id").where(ciws.join(" OR "))
				end
			end
			if params[:chapter]
				ids = params[:chapter].split(/,/)
				if ids.count > 0
					cws = []
					ids.each do |id|
						cws << "chapter_id = #{id}"
					end
					@events = @events.where(cws.join(" OR "))
				end
			end
			if params[:person_type]
				ids = params[:person_type].split(/,/)
				if ids.count > 0
					ptws = []
					ids.each do |id|
						ptws << "events_person_types.person_type_id = #{id}"
					end
					@events = @events.joins("JOIN events_person_types ON events_person_types.event_id = events.id").where(ptws.join(" OR "))
				end
			end
			@events = @events.uniq
			render :action => 'ajax_list', :layout => false
			return
		end
		render :action => 'index'
	end

end
