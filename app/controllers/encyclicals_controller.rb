class EncyclicalsController < ApplicationController

	respond_to :html

	def show
		@encyclical = Encyclical.find(params[:id])
		unless @encyclical.published
			not_found
		else
			respond_with(@encyclical)
		end
	end
end
