class LocationsController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

  respond_to :html

  def index
    respond_with(@locations = Location.all)
  end

  def show
    respond_with(@location = Location.find(params[:id]))
  end

  def new
    respond_with(@location = Location.new)
  end

  def create
    respond_with(@location = Location.create(params[:location]), :location => locations_url)
  end

  def edit
    respond_with(@location = Location.find(params[:id]))
  end

  def update
    respond_with(@location = Location.update(params[:id], params[:location]), :location => locations_url)
  end

  def destroy
    respond_with(@location = Location.delete(params[:id]), :location => locations_url)
  end

end
