class RoleTypesController < ApplicationController

	respond_to :html

	def show
		@role_type = RoleType.find(params[:id])
		unless @role_type.published
			not_found
		else
			respond_with(@role_type)
		end
	end
end
