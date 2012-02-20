class Admin::RoleTypesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@role_types = RoleType.order(:weight))
	end

	def show
		@role_type = RoleType.find(params[:id])
		respond_with(@role_type)
	end

	def new
		respond_with(@role_type = RoleType.new)
	end

	def create
		@role_type = RoleType.new(params[:role_type])
		@role_type.user = current_user
		@role_type.save!
		respond_with(@role_type, :location => admin_role_types_url)
	end

	def edit
		respond_with(@role_type = RoleType.find(params[:id]))
	end

	def update
		respond_with(@role_type = RoleType.update(params[:id], params[:role_type]), :location => admin_role_types_url)
	end

	def destroy
		respond_with(@role_type = RoleType.delete(params[:id]), :location => admin_role_types_url)
	end

end
