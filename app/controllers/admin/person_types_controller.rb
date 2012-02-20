class Admin::PersonTypesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@person_types = PersonType.order(:weight))
	end

	def show
		@person_type = PersonType.find(params[:id])
		respond_with(@person_type)
	end

	def new
		respond_with(@person_type = PersonType.new)
	end

	def create
		@person_type = PersonType.new(params[:person_type])
		@person_type.user = current_user
		@person_type.save!
		respond_with(@person_type, :location => admin_person_types_url)
	end

	def edit
		respond_with(@person_type = PersonType.find(params[:id]))
	end

	def update
		respond_with(@person_type = PersonType.update(params[:id], params[:person_type]), :location => admin_person_types_url)
	end

	def destroy
		respond_with(@person_type = PersonType.delete(params[:id]), :location => admin_person_types_url)
	end

end
