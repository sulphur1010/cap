class Admin::EncyclicalsController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@encyclicals = Encyclical.order(:name))
	end

	def show
		@encyclical = Encyclical.find(params[:id])
		respond_with(@encyclical)
	end

	def new
		respond_with(@encyclical = Encyclical.new)
	end

	def create
		respond_with(@encyclical = Encyclical.create(params[:encyclical]), :location => admin_encyclicals_url)
	end

	def edit
		respond_with(@encyclical = Encyclical.find(params[:id]))
	end

	def update
		@encyclical = Encyclical.update(params[:id], params[:encyclical])
		respond_with(@encyclical, :location => admin_encyclicals_url)
	end

	def destroy
		respond_with(@encyclical = Encyclical.delete(params[:id]), :location => admin_encyclicals_url)
	end

end
