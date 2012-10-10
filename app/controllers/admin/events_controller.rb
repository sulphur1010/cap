require 'csv'

class Admin::EventsController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@events = Event.order(:start_date))
	end

	def user_list
		@event = Event.find(params[:id])
		csv_data = CSV.generate do |csv|
			csv << ["Last Name","First Name","Email","Attendee Count","Amount Paid","Payment Method","Person Type","Chapter","Roles"]
			@event.attendees_events.includes(:attendee).each do |attendee_event|
				csv << [
					attendee_event.last_name,
					attendee_event.first_name,
					attendee_event.email,
					attendee_event.count,
					ActionController::Base.helpers.number_to_currency(attendee_event.total_cost),
					attendee_event.payment_method,
					(attendee_event.attendee.person_type.name rescue ''),
					(attendee_event.attendee.chapter.name rescue ''),
					(attendee_event.attendee.roles.join(", ") rescue '')
				]
			end
		end
		send_data csv_data,
			:type => 'text/csv; charset=iso-8859-1; header=present',
			:disposition => "attachment; filename=event_#{@event.id}_user_list.csv"
	end

	def show
		respond_with(@event = Event.find(params[:id]))
	end

	def new
		respond_with(@event = Event.new)
	end

	def create
		respond_with(@event = Event.create(params[:event]), :location => admin_events_url)
	end

	def edit
		respond_with(@event = Event.find(params[:id]))
	end

	def update
		respond_with(@event = Event.update(params[:id], params[:event]), :location => admin_events_url)
	end

	def destroy
		respond_with(@event = Event.delete(params[:id]), :location => admin_events_url)
	end

end
