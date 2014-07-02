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
			csv << ["Last Name","First Name","Occupation","Address","City","Zip","Email","Telephone","Fax","Mobile","Attendee Count","Attendee Dinner Count","Guest Name","Amount Paid","Payment Method"]
			@event.attendees_events.includes(:attendee).each do |attendee_event|
				csv << [
					attendee_event.last_name,
					attendee_event.first_name,
					attendee_event.occupation,
					attendee_event.address,
					attendee_event.city,
					attendee_event.zip,
					attendee_event.email,
					attendee_event.telephone,
					attendee_event.fax,
					attendee_event.mobile,
					attendee_event.count,
					attendee_event.dinner_count,
					attendee_event.guest_name,
					ActionController::Base.helpers.number_to_currency(attendee_event.total_cost),
					attendee_event.payment_method
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
		respond_with(@event = Event.update(params[:id], params[:event]), :location => event_path(@event))
	end

	def destroy
		respond_with(@event = Event.delete(params[:id]), :location => admin_events_url)
	end

end
