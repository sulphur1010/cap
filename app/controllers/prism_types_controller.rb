class PrismTypesController < ApplicationController

	respond_to :html

	def show
		@prism_type = PrismType.find(params[:id])
		unless @prism_type.published
			not_found
		else
			respond_with(@prism_type)
		end
	end
end
