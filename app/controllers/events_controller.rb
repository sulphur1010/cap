class EventsController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

  respond_to :html

  def index
    respond_with(@events = Event.order(:start_date))
  end

  def show
    respond_with(@event = Event.find(params[:id]))
  end

  def new
    respond_with(@event = Event.new)
  end

  def create
    respond_with(@event = Event.create(params[:event]), :location => events_url)
  end

  def edit
    respond_with(@event = Event.find(params[:id]))
  end

  def update
    respond_with(@event = Event.update(params[:id], params[:event]), :location => events_url)
  end

  def destroy
    respond_with(@event = Event.delete(params[:id]), :location => events_url)
  end

end
