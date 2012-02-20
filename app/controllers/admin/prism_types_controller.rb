class Admin::PrismTypesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@prism_types = PrismType.order(:weight))
	end

	def show
		@prism_type = PrismType.find(params[:id])
		respond_with(@prism_type)
	end

	def new
		respond_with(@prism_type = PrismType.new)
	end

	def create
		@prism_type = PrismType.new(params[:prism_type])
		@prism_type.user = current_user
		@prism_type.save!
		respond_with(@prism_type, :location => admin_prism_types_url)
	end

	def edit
		respond_with(@prism_type = PrismType.find(params[:id]))
	end

	def update
		respond_with(@prism_type = PrismType.update(params[:id], params[:prism_type]), :location => admin_prism_types_url)
	end

	def destroy
		respond_with(@prism_type = PrismType.delete(params[:id]), :location => admin_prism_types_url)
	end

end
