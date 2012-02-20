class EncyclicalsController < ApplicationController

	respond_to :html

	def index
		respond_width(@encyclicals = Encyclical.where(:published => true))
	end

	def show
		@encyclical = Encyclical.find(params[:id])
		unless @encyclical.published
			not_found
		else
			respond_with(@encyclical)
		end
	end
end
