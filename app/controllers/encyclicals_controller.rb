class EncyclicalsController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

	respond_to :html

	def index
		respond_with(@encyclicals = Encyclical.order(:name))
	end

	def show
		@encyclical = Encyclical.find(params[:id])
		unless @encyclical.published
			not_found
		else
			respond_with(@encyclical)
		end
	end

	def new
		respond_with(@encyclical = Encyclical.new)
	end

	def create
		respond_with(@encyclical = Encyclical.create(params[:encyclical]), :location => encyclicals_url)
	end

	def edit
		respond_with(@encyclical = Encyclical.find(params[:id]))
	end

	def update
		respond_with(@encyclical = Encyclical.update(params[:id], params[:encyclical]), :location => encyclicals_url)
	end

	def destroy
		respond_with(@encyclical = Encyclical.delete(params[:id]), :location => encyclicals_url)
	end

end
