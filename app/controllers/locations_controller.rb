class LocationsController < ApplicationController

	respond_to :html

	before_filter :require_admin!, :except => [ :show ]

	def show
		respond_with(@location = Location.find(params[:id]))
	end
end
