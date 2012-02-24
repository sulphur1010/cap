class EventsController < ApplicationController

	respond_to :html

	def index
		if request.xhr?
			@events = Event.order(:start_date)
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
		respond_with(@events = Event.order(:start_date))
	end

	def show
		respond_with(@event = Event.find(params[:id]))
	end

	def rsvp
		@event = Event.find(params[:id])
		unless user_signed_in?
			session[:return_url] = rsvp_event_url(@event)
			redirect_to new_user_registration_url, :notice => 'You must register in order to RSVP.'
			return
		end
		if @event.spots_left > 0
			if @event.attendees.include?(current_user)
				redirect_to events_url, :notice => 'You are already attending that event.'
				return
			end
			@event.attendees << current_user
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

end
