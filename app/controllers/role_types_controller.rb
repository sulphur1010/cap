class RoleTypesController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

	respond_to :html

	def index
		respond_with(@role_types = RoleType.order(:weight))
	end

	def show
		@role_type = RoleType.find(params[:id])
		unless @role_type.published
			not_found
		else
			respond_with(@role_type)
		end
	end

	def new
		respond_with(@role_type = RoleType.new)
	end

	def create
		@role_type = RoleType.new(params[:role_type])
		@role_type.user = current_user
		@role_type.save!
		respond_with(@role_type, :location => role_types_url)
	end

	def edit
		respond_with(@role_type = RoleType.find(params[:id]))
	end

	def update
		respond_with(@role_type = RoleType.update(params[:id], params[:role_type]), :location => role_types_url)
	end

	def destroy
		respond_with(@role_type = RoleType.delete(params[:id]), :location => role_types_url)
	end

end
