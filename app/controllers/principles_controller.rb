class PrinciplesController < ApplicationController

	respond_to :html

	def show
		@principle = Principle.find(params[:id])
		unless @principle.published
			not_found
		else
			respond_with(@principle)
		end
	end

end
